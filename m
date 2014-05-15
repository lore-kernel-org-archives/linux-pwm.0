From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [rfc]pwm: add xilinx pwm driver
Date: Thu, 15 May 2014 12:33:53 +0200
Message-ID: <33a1dbfc-bacb-4804-a83a-9915eca3183b@BY2FFO11FD032.protection.gbl>
References: <1400066773-14393-1-git-send-email-bart.tanghe@thomasmore.be>
 <4262573.aEBTd7FzV5@wuerfel> <53747FB8.2090706@thomasmore.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bl2lp0209.outbound.protection.outlook.com ([207.46.163.209]:16281
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750916AbaEOKef (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 15 May 2014 06:34:35 -0400
In-Reply-To: <53747FB8.2090706@thomasmore.be>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Bart Tanghe <bart.tanghe@thomasmore.be>, Arnd Bergmann <arnd@arndb.de>
Cc: thierry.reding@gmail.com, michal.simek@xilinx.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, grant.likely@linaro.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/15/2014 10:50 AM, Bart Tanghe wrote:
> On 05/15/2014 09:23 AM, Arnd Bergmann wrote:
>> On Wednesday 14 May 2014 13:26:13 Bart Tanghe wrote:
>>> @@ -0,0 +1,20 @@
>>> +Xilinx PWM controller
>>> +
>>> +Required properties:
>>> +- compatible: should be "xlnx,pwm-xlnx"
>>> +- add a clock source to the description
>>> +
>>> +Examples:
>>> +
>>> +               axi_timer_0: timer@42800000 {
>>> +                       clock-frequency = <100000000>;
>>> +                       clocks = <&clkc 15>;
>>> +                       compatible = "xlnx,xlnx-pwm";
>>> +                       reg = <0x42800000 0x10000>;
>>> +                       xlnx,count-width = <0x20>;
>>> +                       xlnx,gen0-assert = <0x1>;
>>> +                       xlnx,gen1-assert = <0x1>;
>>> +                       xlnx,one-timer-only = <0x0>;
>>> +                       xlnx,trig0-assert = <0x1>;
>>> +                       xlnx,trig1-assert = <0x1>;
>>> +               } ;
>>>
>>
>> It seems you are missing a mandatory "#pwm-cells" property.
>> How is anybody supposed to use this?
>>
>>     Arnd
>>
> 
> I've added some additional information in the documentation
> 
> 
> 
> Xilinx PWM controller
> 
> This driver works together with the Xilinx Axi timer hardware core.
> The core is available for the microblaze, powerpc and arm based Xilinx
> platforms.
> 
> The axi timer core is implemented in the pl (programmable logic) of the
> fpga. The amount is user defined. Each core has two timers and one pwm output.

For PWM you have to have 2 timers but core itself can be configured
to any configuration and I expect that any output has to be used.

Can you describe me your testing enviroment with zedboard?
Do you use any additional hw or are using just leds or any device
on zedboard?

Thanks,
Michal


