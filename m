From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: [BUG] pwm: sysfs: It is not possible to export more than one channel
Date: Tue, 25 Sep 2018 11:11:32 +0200
Message-ID: <cd7b3cad-98bf-d976-2e30-0b018f51f90a@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Gottfried Haider <gottfried.haider@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, H Hartley Sweeten <hsweeten@visionengravers.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in
sysfs") it is not possible to export more than one PWM channel.

This is because for each exported channel a directory named pwmN is
created in /sys/class/pwm/. As channels for all PWM chips are numbered
from 0 it is not possible to export pwmN channel from one chip and
pwmN channel from another chip at the same time.

In theory if your SoC has N PWM chips and each chip has N channels you
should be able to export N channels. But only one channel from each chip.

I found the issue on i.MX6dl SoC with two PWM chips where each PWM chip
has just one channel.

This is how it can be reproduced:

root@hydraco:/sys/class/pwm# ls
pwmchip0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmchip0
pwmchip1 -> ../../devices/soc0/soc/2000000.aips-bus/208c000.pwm/pwm/pwmchip1

root@hydraco:/sys/class/pwm# cat pwmchip0/npwm
1
root@hydraco:/sys/class/pwm# cat pwmchip1/npwm
1

root@hydraco:/sys/class/pwm# echo 0 > pwmchip0/export
root@hydraco:/sys/class/pwm# ls -l
pwm0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmchip0/pwm0
pwmchip0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmchip0
pwmchip1 -> ../../devices/soc0/soc/2000000.aips-bus/208c000.pwm/pwm/pwmchip1

root@hydraco:/sys/class/pwm# echo 0 > pwmchip1/export
[  543.110824] sysfs: cannot create duplicate filename '/class/pwm/pwm0'
[  543.117314] CPU: 1 PID: 351 Comm: sh Not tainted 4.19.0-rc5-00025-g249f3ed-dirty #8
[  543.124990] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  543.131587] [<80112d20>] (unwind_backtrace) from [<8010ddb4>] (show_stack+0x20/0x24)
[  543.139383] [<8010ddb4>] (show_stack) from [<80ba1044>] (dump_stack+0x80/0x94)
[  543.146652] [<80ba1044>] (dump_stack) from [<8031e2b4>] (sysfs_warn_dup+0x6c/0x78)
[  543.154257] [<8031e2b4>] (sysfs_warn_dup) from [<8031e61c>] (sysfs_do_create_link_sd+0xd8/0xdc)
[  543.162988] [<8031e61c>] (sysfs_do_create_link_sd) from [<8031e678>] (sysfs_create_link+0x38/0x44)
[  543.171986] [<8031e678>] (sysfs_create_link) from [<806026b0>] (device_add+0x2c8/0x630)
[  543.180025] [<806026b0>] (device_add) from [<80602a3c>] (device_register+0x24/0x28)
[  543.187724] [<80602a3c>] (device_register) from [<80501acc>] (export_store+0x118/0x190)
[  543.195762] [<80501acc>] (export_store) from [<805ffc10>] (dev_attr_store+0x28/0x34)
[  543.203539] [<805ffc10>] (dev_attr_store) from [<8031d7dc>] (sysfs_kf_write+0x48/0x54)
[  543.211485] [<8031d7dc>] (sysfs_kf_write) from [<8031cde0>] (kernfs_fop_write+0xf8/0x1e0)
[  543.219696] [<8031cde0>] (kernfs_fop_write) from [<80294d78>] (__vfs_write+0x48/0x170)
[  543.227645] [<80294d78>] (__vfs_write) from [<80295064>] (vfs_write+0xb4/0x1c0)
[  543.234981] [<80295064>] (vfs_write) from [<802952e8>] (ksys_write+0x5c/0xbc)
[  543.242144] [<802952e8>] (ksys_write) from [<80295360>] (sys_write+0x18/0x1c)
[  543.249313] [<80295360>] (sys_write) from [<80101000>] (ret_fast_syscall+0x0/0x54)
[  543.256901] Exception stack(0xecfbffa8 to 0xecfbfff0)
[  543.261980] ffa0:                   00000002 76fc8000 00000001 76fc8000 00000002 00000000
[  543.270184] ffc0: 00000002 76fc8000 76f5cd60 00000004 00000002 000bd134 00000001 000ba730
[  543.278380] ffe0: 00000000 7ebff954 76e8b988 76ee3cd0
-sh: echo: write error: File exists

I am not sure what will be the right solution. The problem is that
numbering of the PWM channels does not work the same way as in the GPIO
subsystem where each GPIO has its unique number.

Should we just revert the change? It was not documented in the PWM sysfs
interface. What do you think?

Michal
