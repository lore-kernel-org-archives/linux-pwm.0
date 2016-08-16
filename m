From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 0/4] pwm: Add Amlogic Meson SoC PWM Controller
Date: Tue, 16 Aug 2016 08:20:00 -0500
Message-ID: <CAOi56cWRwc28RcRopLpRiFLX-rft-KfgMZHwDGFG3f6tJ_8kYw@mail.gmail.com>
References: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com> <CAOi56cVGRpSeAVwaATkx8Q2wz9hxocq6095opJQZucfDML2wSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi56cVGRpSeAVwaATkx8Q2wz9hxocq6095opJQZucfDML2wSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Aug 3, 2016 at 7:25 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Hi Thierry,
>
> On Sun, Jul 10, 2016 at 2:27 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> Add support for the PWM controller found in Amlogic Meson SoCs.
>> This controller provides a dual PWM output with 4 selectable clock source
>> and a two level divider to achieve a better PWM range.
>>
>> Currently Meson8b and GXBB SoCs are supported.
>>
>> Changes since v1 at http://lkml.kernel.org/r/1466173784-15625-1-git-send-email-narmstrong@baylibre.com :
>> - fix meson8b dtsi
>
> Gentle reminder ping on this series.
>

One more... :)
