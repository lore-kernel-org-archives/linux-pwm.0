From: Claudiu Beznea <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v2 02/16] pwm: pxa: update documentation regarding
 pwm-cells
Date: Mon, 22 Jan 2018 10:47:13 +0200
Message-ID: <6889fdc0-6d61-830e-dad5-2efc02b1b277@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-3-git-send-email-claudiu.beznea@microchip.com>
 <20180119223024.m5kuc6467xmgkgac@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180119223024.m5kuc6467xmgkgac@rob-hp-laptop>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Dunn <mikedunn-kFrNdAxtuftBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org



On 20.01.2018 00:30, Rob Herring wrote:
> On Fri, Jan 12, 2018 at 04:22:49PM +0200, Claudiu Beznea wrote:
>> pwm-cells should be at least 2 to provide channel number and period value.
>>
>> Cc: Mike Dunn <mikedunn-kFrNdAxtuftBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>> index 5ae9f1e3c338..a0e20edeeebc 100644
>> --- a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>> @@ -10,7 +10,7 @@ Required properties:
>>    Note that one device instance must be created for each PWM that is used, so the
>>    length covers only the register window for one PWM output, not that of the
>>    entire PWM controller.  Currently length is 0x10 for all supported devices.
>> -- #pwm-cells: Should be 1.  This cell is used to specify the period in
>> +- #pwm-cells: Should be 2.  This cell is used to specify the period in
>>    nanoseconds.
> 
> What's the new cell? channel? Does the PXA PWM have more than one 
> channel? If not, then you shouldn't add a cell.
The new cell had to be period, to have a generic OF function in the kernel,
to parse the pwms bindings for all PWMs, something like
pwms=<pwm channel-number pwm-period>. After several discussions on this
series, I found that old DT binaries must be compatible with latest kernel
version and this series doesn't guarantee this. So I will drop this change
in next version.

Thank you,
Claudiu Beznea
> 
> Rob
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
