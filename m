From: Hao Zhang <hao5781286@gmail.com>
Subject: Re: [PATCH v1 3/4] ARM: dts: add pwm pins for r40.
Date: Sun, 14 Jan 2018 15:07:46 +0800
Message-ID: <CAJeuY7-FeiEtSkg=udnEx_==3SS=dinyk7fKqhLwdXcKE3510g@mail.gmail.com>
References: <20180111113323.GA21976@arx-s1> <20180111124701.g52kjm3hozn72je5@flea.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20180111124701.g52kjm3hozn72je5@flea.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

2018-01-11 20:47 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> Hi,
>
> On Thu, Jan 11, 2018 at 07:33:23PM +0800, hao_zhang wrote:
>> This patch add pwm pins for r40.
>>
>> Signed-off-by: hao_zhang <hao5781286@gmail.com>
>
> You should order your patches differently. We try to be as bisectable
> as possible, and if we just apply this patch the DT will not compile
> anymore.
>
> Your patch 4 should come before this one.
>

Do you mean that the order of patch be applied is from the first to
the last in the patch set ?
because you apply the last patch first also break the DT compile...

Thinks :)
Hao Zhang

> Your commit title and log doesn't seem to match the content of the
> patch either.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
