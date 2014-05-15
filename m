From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [rfc]pwm: add xilinx pwm driver
Date: Thu, 15 May 2014 09:23:59 +0200
Message-ID: <4262573.aEBTd7FzV5@wuerfel>
References: <1400066773-14393-1-git-send-email-bart.tanghe@thomasmore.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1400066773-14393-1-git-send-email-bart.tanghe@thomasmore.be>
Sender: linux-doc-owner@vger.kernel.org
To: Bart Tanghe <bart.tanghe@thomasmore.be>
Cc: thierry.reding@gmail.com, michal.simek@xilinx.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, grant.likely@linaro.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wednesday 14 May 2014 13:26:13 Bart Tanghe wrote:
> @@ -0,0 +1,20 @@
> +Xilinx PWM controller
> +
> +Required properties:
> +- compatible: should be "xlnx,pwm-xlnx"
> +- add a clock source to the description
> +
> +Examples:
> +
> +               axi_timer_0: timer@42800000 {
> +                       clock-frequency = <100000000>;
> +                       clocks = <&clkc 15>;
> +                       compatible = "xlnx,xlnx-pwm";
> +                       reg = <0x42800000 0x10000>;
> +                       xlnx,count-width = <0x20>;
> +                       xlnx,gen0-assert = <0x1>;
> +                       xlnx,gen1-assert = <0x1>;
> +                       xlnx,one-timer-only = <0x0>;
> +                       xlnx,trig0-assert = <0x1>;
> +                       xlnx,trig1-assert = <0x1>;
> +               } ;
> 

It seems you are missing a mandatory "#pwm-cells" property.
How is anybody supposed to use this?

	Arnd
