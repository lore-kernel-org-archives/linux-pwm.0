From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [rfc]pwm: add xilinx pwm driver
Date: Thu, 15 May 2014 18:30:13 +0200
Message-ID: <16896948.U7hTsgDub4@wuerfel>
References: <1400066773-14393-1-git-send-email-bart.tanghe@thomasmore.be> <5049141.XmehsUeakV@wuerfel> <5374C773.6070402@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5374C773.6070402@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: monstr@monstr.eu
Cc: Bart Tanghe <bart.tanghe@thomasmore.be>, thierry.reding@gmail.com, michal.simek@xilinx.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, grant.likely@linaro.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thursday 15 May 2014 15:56:03 Michal Simek wrote:
> IP is configurable as is normal for us.
> You can select IP with just one timer.
> It means register locations for specific timer are fixed.
> http://www.xilinx.com/support/documentation/ip_documentation/xps_timer.pdf
> 
> timer0 - offset 0x0
> timer1 - offset 0x10 (doesn't need to be synthesized)
> 
> There is one interrupt for both timers.
> 
> Timers can be as timers (up/down count/ reload with or without IRQs)
> But then one options is to use both timers and generate PWM signal.
> From full ip description in DT you can see xlnx,gen0-assert = <1>;
> which can suggest that this IP can output PMW signal.
> (We can also detect if PWM0 signal is connected just to be sure
> that PWM can be enabled).
> 
> There is also capture trigger mode where external signal start/stop
> timer counting.
> 
> It means there are 3 modes - timer, capture and PWM.
> Timer (clocksource, clockevent) requires specific handling,
> PWM has own subsystem and not sure if there is any subsystem for
> capture mode. Is there any?

I don't think so. Possibly somewhere in IIO.

> Not every timer configuration is suitable for all things
> but fully configured timer can be used in all 3 modes.
> 
> 
> I think that make sense to register and map all timers in the system
> and classify them with flags (like can't be used for capture or PMW
> if there are not outputs connected) and then use the best
> timer for clocksource and clockevent. The best candidate is IP
> with the lowest IRQ number in dual timer mode but in general
> whatever timer can be used that's why we can't probably avoid
> timer specification in DT.
> In spite of this smells because you are saying via DT
> to Linux which timer should be used for what purpose.

We had discussions about this in the past, but I don't remember the
outcome of that.

	Arnd
