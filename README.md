ansible-ltc-mining-on-ec2
=========================

Introduction
------------
  Based on AWS spot instance pricing, LTC mining difficulty, and the present value of LTC, it can be profitable to mine for LTC on EC2 g2.2xlarge instances.

  This project was inspired by Bob Feldbauer's post on [Profitable LiteCoin Mining on EC2](http://www.completefusion.com/profitable-litecoin-mining-on-ec2/), and a desire to practice my Ansible chops.

A few reasons why this project is useful:
 - short-term profit _if_ EC2 costs, LTC difficulty, and LTC value is sufficiently high.
 - long-term speculation, since it may not be profitable at today's rates, but you may break even later.
 - an easy (slow?) way to obtain LTC if purchasing coins is not possible / too difficult.
 - a fun way to dabble in Ansible :)

 Note, as Bob Feldbaur points out:

    ````
    Note that EC2 limits you to 10 g2.2xlarge spot instances per region, so you'll need to run them in multiple regions to get more than 10 instances
    ````

So, to maximize the number of workers, launch 10 instances per region, and repeat with multiple AWS accounts.

Setup
-----
  1. Create an account at [WeMineLTC.com](http://wemineltc.com), the supported LTC mining pool.
  2. Configure two new miners, one for GPU and one for CPU processing.  The suggested settings at [Profitable LiteCoin Mining on EC2](http://www.completefusion.com/profitable-litecoin-mining-on-ec2/) are perfect:

    ````
    "For the GPU worker, I would recommend setting the "Suggest Diff" at 16 and "Max Diff" at 128. For the CPU worker, set "Suggest Diff" at 8 and "Max Diff" at 64."
    ````

Usage
-----
  1. Bid and launch g2.2xlarge (or cg1.4xlarge) instances, via the [Amazon Linux AMI (HVM) 2013.09.1](http://aws.amazon.com/amazon-linux-ami/2013.09-release-notes/) image.
  2. Add your new EC2 instance hostnames to ````inventory.yml```` under the appropriate instance type group.
  3. Save the necessary keypairs locally to ````$HOME/.ssh/aws.pem```` (or configure PEM_FILE in the Makefile)
  4. Configure GPU & CPU worker credentials in ````group_vars / all````
  5. Run ````make run````
     - Installs ansible
     - Runs the ````ltcminers.yml```` playbook
     - Launches miners on remote instances
  6. Wait for the results to trickle in at [WeMineLTC.com](http://wemineltc.com)
  7. ...
  8. Profit!

Future Ideas
------------
 - Replace the stop + start tasks in the playbook with proper init.d start scripts
 - Automate the EC2 Spot Instances bid process, and have playbooks auto-run on instance deployment
