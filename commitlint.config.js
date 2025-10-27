// commitlint.config.js
// eslint-disable-next-line no-undef
module.exports = {

  rules: {
    /*
      1. TẮT các rule mặc định kiểu "type-empty", "subject-empty"
         vì parser mặc định không hiểu format custom của bạn.
         Nếu để bật (mức 2), nó sẽ luôn fail trước khi tới rule custom.
    */
    'type-empty': [0],
    'subject-empty': [0],
    'type-enum': [0],
    'subject-full-stop': [0],
    'subject-case': [0],
    'header-max-length': [0],

    /*
      2. BẬT rule custom duy nhất, kiểm tra full header bằng regex.
         Đây là luật thực sự sẽ decide commit pass/fail.
    */
    'team-header-pattern': [
      2,
      'always',
      // Giải thích regex:
      // ^(TYPE)\((PLATFORM)\)(/(AREA))?: SUBJECT
      //
      // TYPE         = feat|fix|refactor|chore|docs|style|test|perf|build
      // PLATFORM     = [a-z0-9-]+        (vd: flutter, react-web, ios, global, infra...)
      // AREA (opt)   = /[a-z0-9-]+       (vd: note-provider, api-client, husky...)
      // SUBJECT      = sau dấu ": " phải có ít nhất 1 ký tự
      //
      // Cho phép:
      //   chore(global): update something
      //   chore(global)/husky: update hook
      //   feat(flutter)/note-provider: add hive storage
      //
      '^(feat|fix|refactor|chore|docs|style|test|perf|build)\\(([a-z0-9-]+)\\)(?:\\/([a-z0-9-]+))?:\\s.+$'
    ]
  },

  plugins: [
    {
      rules: {
        'team-header-pattern': ({ header }, when = 'always', pattern) => {
          const re = new RegExp(pattern);
          const ok = re.test(header);

          return [
            when === 'always' ? ok : !ok,
            ok
              ? ''
              : [
                  '❌ Commit message không đúng convention monorepo.',
                  `   → ${header}`,
                  '',
                  '✅ Format hợp lệ:',
                  '   <type>(<platform>): <subject>',
                  '   <type>(<platform>)/<area>: <subject>',
                  '',
                  'Trong đó:',
                  '   type      = feat | fix | refactor | chore | docs | style | test | perf | build',
                  '   platform  = flutter | react-web | ios | shared | infra | global | ...',
                  '   area      = phần cụ thể trong platform (kebab-case), VD: note-provider, api-client, husky',
                  '',
                  'Ví dụ commit đúng:',
                  '   chore(global)/husky: update pre-commit hook',
                  '   feat(flutter)/note-provider: add hive persistence',
                  '   fix(react-web)/api-client: handle token refresh',
                  '   docs(global): add setup guide for contributors'
                ].join('\n')
          ];
        }
      }
    }
  ]
};