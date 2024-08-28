Run the perl script to generate the blog and upload the `generated` folder to your hosting provider.

```bash
# Before running it, you must install 2 packages:
# if cpan fails, run `whereis cpan` and replace it down below
sudo cpan install Text::Markdown File::Find
perl pblogfy.pl
```
