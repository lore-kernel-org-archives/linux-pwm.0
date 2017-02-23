From: m18063 <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH 2/2] drivers: pwm: pwm-atmel: add support to allow run
 time changing of pwm parameters
Date: Thu, 23 Feb 2017 17:22:36 +0200
Message-ID: <8123991c-5e3c-ad5c-bbf3-bcd7ee2a5e5e@microchip.com>
References: <1487839120-13650-1-git-send-email-claudiu.beznea@microchip.com>
 <1487839120-13650-3-git-send-email-claudiu.beznea@microchip.com>
 <20170223092148.5qmxy62xkufwbsrw@piout.net>
 <f963def2-6d82-3bf7-22fa-8915f408ca54@microchip.com>
 <20170223103239.tv6nodddlar5l5fl@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170223103239.tv6nodddlar5l5fl-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


On 23.02.2017 12:32, Alexandre Belloni wrote:
> On 23/02/2017 at 12:25:58 +0200, m18063 wrote:
>>> It is probably worth switching to atomic PWM instead of changing this
>>> function. This would simplify the whole driver.
>> I was thinking to switch to atomic PWM in a future patch.
> Then why wait ?
>
>
I wanted to do it in progressively:
- enable the support for SAMA5d2
- make it work based on what is currently implemented
- add atomic PWM support.

Anyway, please ignore this patch. I will do it in atomic
PWM way.

Thank you,
Claudiu

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
