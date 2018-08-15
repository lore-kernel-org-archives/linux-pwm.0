From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
Date: Wed, 15 Aug 2018 17:41:52 +0200
Message-ID: <4def26df-0f4b-77e5-fea9-6c8f3537d831@axentia.se>
References: <20180812184152.GA22343@ravnborg.org>
 <f1f2a2d7-ae27-87af-8041-93d3f8fe07cc@microchip.com>
 <20180813181808.GA2357@ravnborg.org> <20180813220454.GA28913@rob-hp-laptop>
 <20180814164343.GA13848@ravnborg.org> <20180814224252.GA20667@rob-hp-laptop>
 <20180815044808.GA1806@ravnborg.org>
 <CAL_JsqLwazj=7hOwSeAtcyvnYCmMDP-Nw3H8xHSr0n3YGUS21A@mail.gmail.com>
 <CAKMK7uHm03UxLNUieJFR4TD3ppTMHwkitbQTrVq67K=Mjh6OYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKMK7uHm03UxLNUieJFR4TD3ppTMHwkitbQTrVq67K=Mjh6OYA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Joshua Henderson <joshua.henderson@microchip.com>, dri-devel <dri-devel@lists.freedesktop.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Sam Ravnborg <sam@ravnborg.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On 2018-08-15 17:04, Daniel Vetter wrote:
> On Wed, Aug 15, 2018 at 4:45 PM, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Aug 14, 2018 at 10:48 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>>>
>>
>> [...]
>>
>>>>> One DT related Q:
>>>>> The LCD Controller supports BGR565, but as this is less common some HW implmentations
>>>>> exchange R and B, expessed in the old binding as wiring-mode like this:
>>>>>
>>>>>     atmel,lcd-wiring-mode: lcd wiring mode "RGB" or "BRG"
>>>>>
>>>>> How can we express this wiring-mode in a generic way, both in DT and in code?
>>>>> Is it something that in DRM belongs to the panel, the encoder, the connector, or?
>>>>> And can any of the exisitng flags be used?
>>>>
>>>> I thought we had come up with a common definition, but I guess it didn't
>>>> make it upstream. It's definitely needed and I've been rejecting
>>>> anything new that's vendor specific.
>>> I found this: https://patchwork.ozlabs.org/patch/659570/
>>> The suggestion with a boolean seems simple and I will try that.
>>
>> That's really too simple to be common. There's been a few other
>> attempts[1][2][3] (for Atmel HLCDC in fact) with [3] probably being
>> the closest to merging. The binding looked fine to me, but looks like
>> the DRM implementation had some issues.
>>
>> Rob
>>
>> [1] https://lists.freedesktop.org/archives/dri-devel/2018-April/173089.html
>> [2] https://patchwork.kernel.org/patch/9965079/
>> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/568731.html
> 
> There's a standardized bus_format for drm_panel. IIrc there's been
> discussions to add something similar to drm_bridge, but didn't go all
> that far for reasons.
> 
> Lots of drivers just handle this internally in some way. So no idea
> why this all got stalled.

I stopped pushing that patch for reasons mentioned in
https://lkml.org/lkml/2018/4/9/108

However, since then, the component approach mentioned in that mail was
shot down and instead the tda998x driver is now a bridge (or soon, I expect
the series from Russell King that to land in 4.19-rc1) which means that the
binding from that series is back on the table. At least I guess so? However,
in that series the approach is that the bridge states its expected input and
the output then adjusts to what is needed. However, the "problem" is really in
the atmel-hlcdc output (it moves the MSB for the RGB colors around depending
on the output mode) so I no longer subscribe to all ideas in that series
and think it is cleaner to state the needed bus format closer to the atmel-
hlcdc endpoint as is done e.g. in this latest series:

https://lkml.org/lkml/2018/8/10/309

This latest series uses the media/video-interface approach and specifies
the bus-width in the endpoint. However, the bus-width is alone obviously not
enough to differentiate rgb565 and brg565, so will not help Sam (or is it
bgr565 that Sam needs? The above quoted text is ambiguous).

I think something like my bus-format binding in [3] is generic enough to
also help Sam.

Cheers,
Peter
