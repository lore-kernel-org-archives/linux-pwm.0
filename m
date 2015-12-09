From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [Oops] Broken pwm backlight for non-dt platforms
Date: Wed, 09 Dec 2015 22:44:45 +0100
Message-ID: <87twnrjnzm.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:39796 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbbLIVos (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Dec 2015 16:44:48 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org


Commit ee65ad0e2a9e "backlight: pwm_bl: Avoid backlight flicker when probed from
DT" triggers an oops on platform_data based platforms.

The issue is I think in pwm_bl.c, line 202 :
	phandle phandle = pdev->dev.of_node->phandle;

Consider what happens when of_node == NULL.

Could you please fix this before it lands into -rc1 ?

Cheers.

--
Robert

[1] My Oops
Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = c0004000
"[00000008] *pgd=00000000
Internal error: Oops: f5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.4.0-rc4-next-20151208+ #1377
Hardware name: MIO A701
M"5f
task: c3858bc0 ti: c385c000 task.ti: c385c000
PC is at pwm_backlight_probe+0x28/0x504
LR is at platform_drv_probe+0x60/0xb8
pc : [<c0244af4>]    lr : [<c028c06c>]    psr: a8000053
sp : c385dd40  ip : c385ddc0  fp : c385ddbc
r10: 00000000  r9 : 00000000  r8 : c0721cf0
/-<f
r7 : c06e2708  r6 : c0703fa4  r5 : c06e3044  r4 : ffffffed
~j=f
r3 : c0244acc  r2 : 00000000  r1 : 00000001  r0 : c06e2708
Flags: NzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 0000397f  Table: a0004000  DAC: 00000053
Process swapper (pid: 1, stack limit = 0xc385c198)
[<c0244af4>] (pwm_backlight_probe) from [<c028c06c>] (platform_drv_probe+0x60/0xb8)
#Hqf
[<c028c06c>] (platform_drv_probe) from [<c0289dd8>] (driver_probe_device+0x1e8/0x458)
c[sf
[<c0289dd8>] (driver_probe_device) from [<c028a0c0>] (__driver_attach+0x78/0x9c)
[<c028a0c0>] (__driver_attach) from [<c0287998>] (bus_for_each_dev+0x64/0xb4)
[<c0287998>] (bus_for_each_dev) from [<c02896d0>] (driver_attach+0x28/0x30)
7Hyf
[<c02896d0>] (driver_attach) from [<c0288f9c>] (bus_add_driver+0x114/0x274)
[<c0288f9c>] (bus_add_driver) from [<c028ac28>] (driver_register+0xb0/0xf8)
[<c028ac28>] (driver_register) from [<c028bf6c>] (__platform_driver_register+0x40/0x54)
[<c028bf6c>] (__platform_driver_register) from [<c06a995c>] (pwm_backlight_driver_init+0x18/0x20)
[<c06a995c>] (pwm_backlight_driver_init) from [<c00097a0>] (do_one_initcall+0x130/0x224)\`
[<c00097a0>] (do_one_initcall) from [<c068ce48>] (kernel_init_freeable+0x100/0x1d4)
[<c068ce48>] (kernel_init_freeable) from [<c04a9ccc>] (kernel_init+0x18/0x100)
[<c04a9ccc>] (kernel_init) from [<c000a5ec>] (ret_from_fork+0x14/0x28)
Code: e5905058 e5909124 e1a07000 e3550000 (e5998008)
---[ end trace 7c8ebe9bc3611280 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

[2]
rj@belgarion:~/mio_linux/kernel$ arm-none-eabi-addr2line -i -e vmlinux c0244af4
/home/rj/mio_linux/kernel/drivers/video/backlight/pwm_bl.c:202
