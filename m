From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: MX28: leds/pwm: Using pwm driven led as heartbeat leads to kernel
 warning
Date: Fri, 04 Apr 2014 15:54:52 +0200
Message-ID: <533EB9AC.6040708@i2se.com>
References: <53345C93.9040005@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63267 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbaDDNz3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Apr 2014 09:55:29 -0400
In-Reply-To: <53345C93.9040005@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@freescale.com>, Thierry Reding <thierry.reding@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-leds@vger.kernel.org

Hello again,

Am 27.03.2014 18:14, schrieb Stefan Wahren:
> Hello,
>
> i'm using a i.MX28 custom board with two leds and Kernel 3.14-rc5.
>
> Here is the relevant dts part:
>
> pwmleds {
>         compatible = "pwm-leds";
>         pinctrl-names = "default";
>         pinctrl-0 = <&pwm0_pins_b>; /* MX28_PAD_AUART1_RX__PWM_0 */
>        
>         led0 {
>             label = "duckbill:red";
>             pwms = <&pwm 0 7812500>;
>             max-brightness = <127>;
>             linux,default-trigger = "none";
>         };
> };
>
> gpioleds {
>         compatible = "gpio-leds";
>         pinctrl-names = "default";
>         pinctrl-0 = <&led_pins>;
>
>         led1 {
>             label = "duckbill:green";
>             gpios = <&gpio3 5 0>;
>             linux,default-trigger = "heartbeat";
>         };
> };
>
> The gpio driven led works perfect as heartbeat. But if i change the
> trigger of the pwm
> driven led from none to heartbeat, it results always in a kernel warning
> and the pwm led
> keeps on:
>
> [  248.916168] WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:856
> mutex_trylock+0x184/0x1a4()
> [  248.924745] DEBUG_LOCKS_WARN_ON(in_interrupt())
> [  248.929136] Modules linked in:
> [  248.932517] CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.0-rc5 #18
> [  248.938781] [<c0015420>] (unwind_backtrace) from [<c0012cb0>]
> (show_stack+0x10/0x14)
> [  248.946672] [<c0012cb0>] (show_stack) from [<c001daf8>]
> (warn_slowpath_common+0x6c/0x8c)
> [  248.954902] [<c001daf8>] (warn_slowpath_common) from [<c001dbac>]
> (warn_slowpath_fmt+0x30/0x40)
> [  248.963742] [<c001dbac>] (warn_slowpath_fmt) from [<c045df74>]
> (mutex_trylock+0x184/0x1a4)
> [  248.972147] [<c045df74>] (mutex_trylock) from [<c0360950>]
> (clk_prepare_lock+0xc/0xec)
> [  248.980132] [<c0360950>] (clk_prepare_lock) from [<c0362020>]
> (clk_get_rate+0xc/0x68)
> [  248.988105] [<c0362020>] (clk_get_rate) from [<c028d07c>]
> (mxs_pwm_config+0x20/0x198)
> [  248.996098] [<c028d07c>] (mxs_pwm_config) from [<c028bde8>]
> (pwm_config+0x60/0x70)
> [  249.003824] [<c028bde8>] (pwm_config) from [<c034b61c>]
> (__led_pwm_set+0x1c/0x3c)
> [  249.011442] [<c034b61c>] (__led_pwm_set) from [<c034bc3c>]
> (led_heartbeat_function+0x70/0x110)
> [  249.020114] [<c034bc3c>] (led_heartbeat_function) from [<c00292f0>]
> (call_timer_fn+0x7c/0x164)
> [  249.028856] [<c00292f0>] (call_timer_fn) from [<c00295c8>]
> (run_timer_softirq+0x1f0/0x260)
> [  249.037267] [<c00295c8>] (run_timer_softirq) from [<c002255c>]
> (__do_softirq+0xc4/0x2f0)
> [  249.045507] [<c002255c>] (__do_softirq) from [<c0022890>]
> (irq_exit+0xa4/0x10c)
> [  249.052966] [<c0022890>] (irq_exit) from [<c0010240>]
> (handle_IRQ+0x34/0x84)
> [  249.060079] [<c0010240>] (handle_IRQ) from [<c0013524>]
> (__irq_svc+0x44/0x54)
> [  249.067358] [<c0013524>] (__irq_svc) from [<c00107f8>]
> (arch_cpu_idle+0x40/0x48)
> [  249.074916] [<c00107f8>] (arch_cpu_idle) from [<c005deb8>]
> (cpu_startup_entry+0x70/0x198)
> [  249.083258] [<c005deb8>] (cpu_startup_entry) from [<c060aac8>]
> (start_kernel+0x2a8/0x2f8)
>
> Best regards
> Stefan Wahren
>

the problem is still reproducable in Mainline 3.14.0 and gives the same
warning message.
Also i add linux-leds in CC.

Are there any advices to narrow down the problem?

Is this problem specific to i.MX28 PWM (i don't have other kind of
hardware)?

Can anybody reproduce this problem?

Kind regards
Stefan Wahren
