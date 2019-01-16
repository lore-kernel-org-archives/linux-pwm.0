From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
Date: Tue, 15 Jan 2019 16:14:21 -0800
Message-ID: <faadc46d-94b5-a32c-79ae-4206fbc26608@broadcom.com>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
 <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
 <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
 <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Praveen Kumar B <praveen.b@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On 2019-01-12 7:05 a.m., Uwe Kleine-König wrote:
> Hello Scott,
>
> On Fri, Jan 11, 2019 at 01:28:45PM -0800, Scott Branden wrote:
>> On 2019-01-11 12:48 p.m., Uwe Kleine-König wrote:
>>> On Fri, Jan 11, 2019 at 10:51:14AM +0530, Sheetal Tigadoli wrote:
>>>> From: Praveen Kumar B <praveen.b@broadcom.com>
>>>>
>>>> Add new compatible string for new version of pwm-kona
>>>>
>>>> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>>>> index 8eae9fe..d37f697 100644
>>>> --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>>>> +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>>>> @@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
>>>>    This controller has 6 channels.
>>>>    Required Properties :
>>>> -- compatible: should contain "brcm,kona-pwm"
>>>> +- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v2"
>>> Is v2 used on a newer generation of kona SoCs? On i.MX these variants
>>> are usually named after the first SoC that came with the new variant. Is
>>> this sensible here, too?
>> It doesn't make as much sense here as different revs of the IP block are
>> picked up based on various decisions.
>>
>> A new SoC could decide to use an old version.
> IMHO this is no reason to not use the name of the oldest SoC with this
> variant. I don't know how the SoC names are in the broadcom family, but
> if they were (in order of age, oldest first):
>
> 	ant
> 	bear
> 	crocodile
>
> and ant and crocodile use the same IP block we would have
>
> a) with v1, v2:
>
> 	ant:
> 		compatible = "brcm,kona-pwm-v1";
> 	bear:
> 		compatible = "brcm,kona-pwm-v2";
> 	crocodile:
> 		compatible = "brcm,kona-pwm-v1";
>
> ; and
>
> b) with the SoC naming:
>
> 	ant:
> 		compatible = "brcm,kona-ant-pwm";
> 	bear:
> 		compatible = "brcm,kona-bear-pwm";
> 	crocodile:
> 		compatible = "brcm,kona-crocodile-pwm", "brcm,kona-ant-pwm";
>
> (If you want, drop "brcm,kona-crocodile-pwm", but keeping it is more
> defensive.)
>
> I like b) (with "...-crocodile-...") better than a). crocodile using
> "...-ant-..." is not more ugly than crocodile using "...-v1". This is
> also a tad more robust because if broadcom releases kona-dolphin and
> someone finds a minor difference between the IPs used on ant and
> crocodile it depends on the order of these events who gets v3, while
> with the SoC naming the result is clear.
>
> (OK, and given that "brcm,kona-pwm" is already fixed, both approaches
> need slight adaption, but I guess you still get what I meant.)

Thanks for your thoughts and explanation.

It is unfortunate devicetree has no proper guidelines or documentation on

binding naming.  In the interest of getting this upstream we can name it

"brcm, omega-pwm".  We can drop kona from the binding name as that 
architecture

is really no more - only IP derived from it is - hence the name kona-v2 
previously.

>
> Best regards
> Uwe
>
>
Cheers,
Scott
