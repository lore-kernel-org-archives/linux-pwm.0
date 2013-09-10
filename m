Return-Path: <mikedunn@newsguy.com>
Message-ID: <522F40A3.9030701@newsguy.com>
Date: Tue, 10 Sep 2013 08:54:11 -0700
From: Mike Dunn <mikedunn@newsguy.com>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v2] pwm: pxa: add device tree support to pwm driver
References: <1378751420-19227-1-git-send-email-mikedunn@newsguy.com> <522E3B5B.90406@wwwdotorg.org>
In-Reply-To: <522E3B5B.90406@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>

On 09/09/2013 02:19 PM, Stephen Warren wrote:
> On 09/09/2013 12:30 PM, Mike Dunn wrote:
>> This patch adds device tree support to the pxa's pwm driver.  Only an OF match
>> table is added; nothing needs to be extracted from the device tree node.  The
>> existing platform_device id table is reused for the match table data.  Support
>> for inverted polarity is also added.
>>
>> Tested on a Palm Treo 680 (both platform data and DT cases).
> 
>> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> 
>> +Marvell pwm controller
> 
> s/pwm/PWM/ throughout.
> 
>> +
>> +Required properties:
>> +- compatible:
>> +  for pxa25x, pxa27x, pxa168, pxa910: must be compatible = "marvell,pxa250-pwm";
> 
> I think you want a separate compatible value for each HW, to allow for
> any HW-specific quirks to be enabled later if required. So, you could
> document "marvell,pxa250-pwm" as the basic compatible value that a
> driver can bind to, yet also document the other values as being required
> for the relevant HW?


IOW...
- compatible: should be one of:
  - "marvell,pxa250-pwm"
  - "marvell,pxa270-pwm"
  - "marvell,pxa168-pwm"
  - "marvell,pxa910-pwm"

Even though the driver makes no functional distinction currently?


> 
>> +- reg: physical base address and length of the registers used by the pwm channel
>> +  NB: One device instance must be created for each pwm that is used, so the
>> +  length covers only the register window for one pwm output, not that of the
>> +  entire pwm controller.  Currently length is 0x10 for all supported devices.
>> +- #pwm-cells: should be 3.
>> +   cell 1: the per-chip index of the PWM to use,
> 
> That cell shouldn't be needed if you really want to have one DT node per
> PWM channel.


Yes, but I was afraid to deviate from the format used by the other PWM
controllers.  (But in that case, it should at least be documented as "must be
zero". Thanks.)  If going my owm way is acceptable, I'll define my own
of_xlate() parser and remove this cell.


> 
>> +   cell 2: the period in nanoseconds,
>> +   cell 3: flags; set bit 0 to specify inverse polarity.  The pwm controller
>> +   does not implement reverse polarity, but some boards may pass the pwm output
>> +   through an external inverter, which can cause problems if a client device
>> +   assumes that an increase in the duty cycle results in an increase in output
>> +   power.  The pwm-backlight is an example of such a client.
> 
> Hmm. I wonder what are the semantics of the PWM subsystem's "inverse
> polarity" flag. What about a HW block that can do inverse polarity, but
> also has an inverter on the board? If we subvert this flag (in this
> case) to mean "there's an inverter on the board", then how can a
> different PWM binding use it to mean "configure the PWM HW block to
> invert the signal"?


Yeah, Thierry shot this down for the same good reasons.  The correct approach
for my issue is to fix the pwm-backlight driver.


I really appreciate the review Stephen.  Thanks again!
Mike
