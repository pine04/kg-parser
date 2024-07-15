# Setup

Đừng chỉnh sửa file gì trong ./jda.

```bash
git clone --recursive https://github.com/pine04/kg-parser
# cd jda
# mvn clean install -DskipTest=true
# Update: không cần chạy nữa, jda ở đây là ref để parse code.
```

Để chạy project:

- Tạo file .env
  - NEO4J_URI
  - NEO4J_USERNAME
  - NEO4J_PASSWORD
  - NEO4J_DATABASE

```bash
python make.py ..args
```

## Note

```text
[WARNING] Some problems were encountered while building the effective model for jda.example:kg-sccl:jar:0.0.0-SNAPSHOT
[WARNING] 'dependencies.dependency.systemPath' for jda.modules:jda-main:jar should not point at files within the project directory, ${project.basedir}/jda/main/target/jda-main-5.4-SNAPSHOT.jar will be unresolvable by dependent projects @ line 48, column 25
```

🙃 Khi nào lỗi này crash chương trình thì fix, còn lại cứ bỏ qua.
