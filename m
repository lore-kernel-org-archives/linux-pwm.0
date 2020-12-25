Return-path: <kever.yang@gmail.com>
MIME-Version: 1.0
From: Kever Yang <kever.yang@rock-chips.com>
Date: Fri, 25 Dec 2020 15:10:44 +0800
Message-ID: <CAKUh=Ry7=WUmN5OYv5g_E1EHk8jNE-QcOtw_BrMbH+_aP68w8Q@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001b5dac05b744a0dc"
Subject: Re: [PATCH v3 0/7] pwm: rockchip: Eliminate potential race condition
 when probing
In-Reply-To: <cover.1608735481.git.simon@simonsouth.net>
To: Simon South <simon@simonsouth.net>
Cc: tpiepho@gmail.com, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, Robin Murphy <robin.murphy@arm.com>, lee.jones@linaro.org, Heiko Stuebner <heiko@sntech.de>, bbrezillon@kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, David Wu <david.wu@rock-chips.com>, steven.liu@rock-chips.com
List-ID: <linux-pwm.vger.kernel.org>

--0000000000001b5dac05b744a0dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ David and Steven,

Hi Steven,
    please help to review this patch set.

Thanks
- Kever
Simon South <simon@simonsouth.net> =E4=BA=8E2020=E5=B9=B412=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:01=E5=86=99=E9=81=93=EF=BC=9A

> This patch series aims to eliminate the race condition Trent Piepho
> identified[0] in the Rockchip PWM driver's rockchip_pwm_probe()
> function, by moving code that checks whether a device is enabled ahead
> of the code that registers it via pwmchip_add().
>
> It has grown to include a number of other small fixes and improvements
> to the driver. It now also
>
> - Fixes a potential kernel hang introduced by my earlier commit
>   457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
>   probing") by ensuring a device's APB clock is enabled before its
>   registers are accessed;
>
> - Removes a superfluous call to clk_unprepare() that could result in
>   warnings from the kernel;
>
> - Clarifies the driver's error messages by replacing "bus clk" with
>   "PWM clk";
>
> - Removes the now-unneeded goto targets from rockchip_pwm_probe();
>
> - Tries to improve rockchip_pwm_probe() by having it enable the signal
>   clock of only PWM devices that are already running; and
>
> - Ensures the driver enables a clock before querying its rate with
>   clk_get_rate(), as stated as a requirement in that function's
>   documentation.
>
> The first patch ("Enable APB clock...") is unchanged from version 2.
>
> New in version 3 are
>
> - Finer patch granularity, with patches 2 and 5 added to clarify
>   changes included with others in v2;
>
> - A rewritten patch 6 ("Enable PWM clock...") with a smaller change
>   and the use of if...else in place of a ternary operator;
>
> - Patches 3 and 7 with fixes suggested by Robin Murphy and Uwe
>   Kleine-K=C3=B6nig; and
>
> - Rewritten and (hopefully) more accurate commit messages.
>
> I've tested these changes on my (RK3399-based) Pinebook Pro with its
> screen backlight enabled by U-Boot and each one appears to work fine.
>
> I'd (still) be grateful for help with testing on other devices,
> particularly those with SoCs like the RK3328 that use separate bus and
> signal clocks for their PWM devices. (My ROCK64 uses its PWM-output
> pins for other purposes and wasn't of help here.)
>
> [0] https://www.spinics.net/lists/linux-pwm/msg14611.html
>
> --
> Simon South
> simon@simonsouth.net
>
>
> Simon South (7):
>   pwm: rockchip: Enable APB clock during register access while probing
>   pwm: rockchip: rockchip_pwm_probe(): Remove superfluous
>     clk_unprepare()
>   pwm: rockchip: Replace "bus clk" with "PWM clk"
>   pwm: rockchip: Eliminate potential race condition when probing
>   pwm: rockchip: rockchip_pwm_probe(): Remove unneeded goto target
>   pwm: rockchip: Enable PWM clock of probed device only if running
>   pwm: rockchip: Enable clock before calling clk_get_rate()
>
>  drivers/pwm/pwm-rockchip.c | 64 ++++++++++++++++++++++++--------------
>  1 file changed, 40 insertions(+), 24 deletions(-)
>
> --
> 2.29.2
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>

--0000000000001b5dac05b744a0dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>+ David and Steven,<br></div><div><br></div><div>Hi S=
teven,</div><div>=C2=A0 =C2=A0 please help to review this patch set.</div><=
div><br></div>Thanks<div>- Kever<br><div><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">Simon South &lt;<a href=3D"mailto:simon@simo=
nsouth.net">simon@simonsouth.net</a>&gt; =E4=BA=8E2020=E5=B9=B412=E6=9C=882=
4=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:01=E5=86=99=E9=81=93=EF=
=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This patc=
h series aims to eliminate the race condition Trent Piepho<br>
identified[0] in the Rockchip PWM driver&#39;s rockchip_pwm_probe()<br>
function, by moving code that checks whether a device is enabled ahead<br>
of the code that registers it via pwmchip_add().<br>
<br>
It has grown to include a number of other small fixes and improvements<br>
to the driver. It now also<br>
<br>
- Fixes a potential kernel hang introduced by my earlier commit<br>
=C2=A0 457f74abbed0 (&quot;pwm: rockchip: Keep enabled PWMs running while<b=
r>
=C2=A0 probing&quot;) by ensuring a device&#39;s APB clock is enabled befor=
e its<br>
=C2=A0 registers are accessed;<br>
<br>
- Removes a superfluous call to clk_unprepare() that could result in<br>
=C2=A0 warnings from the kernel;<br>
<br>
- Clarifies the driver&#39;s error messages by replacing &quot;bus clk&quot=
; with<br>
=C2=A0 &quot;PWM clk&quot;;<br>
<br>
- Removes the now-unneeded goto targets from rockchip_pwm_probe();<br>
<br>
- Tries to improve rockchip_pwm_probe() by having it enable the signal<br>
=C2=A0 clock of only PWM devices that are already running; and<br>
<br>
- Ensures the driver enables a clock before querying its rate with<br>
=C2=A0 clk_get_rate(), as stated as a requirement in that function&#39;s<br=
>
=C2=A0 documentation.<br>
<br>
The first patch (&quot;Enable APB clock...&quot;) is unchanged from version=
 2.<br>
<br>
New in version 3 are<br>
<br>
- Finer patch granularity, with patches 2 and 5 added to clarify<br>
=C2=A0 changes included with others in v2;<br>
<br>
- A rewritten patch 6 (&quot;Enable PWM clock...&quot;) with a smaller chan=
ge<br>
=C2=A0 and the use of if...else in place of a ternary operator;<br>
<br>
- Patches 3 and 7 with fixes suggested by Robin Murphy and Uwe<br>
=C2=A0 Kleine-K=C3=B6nig; and<br>
<br>
- Rewritten and (hopefully) more accurate commit messages.<br>
<br>
I&#39;ve tested these changes on my (RK3399-based) Pinebook Pro with its<br=
>
screen backlight enabled by U-Boot and each one appears to work fine.<br>
<br>
I&#39;d (still) be grateful for help with testing on other devices,<br>
particularly those with SoCs like the RK3328 that use separate bus and<br>
signal clocks for their PWM devices. (My ROCK64 uses its PWM-output<br>
pins for other purposes and wasn&#39;t of help here.)<br>
<br>
[0] <a href=3D"https://www.spinics.net/lists/linux-pwm/msg14611.html" rel=
=3D"noreferrer" target=3D"_blank">https://www.spinics.net/lists/linux-pwm/m=
sg14611.html</a><br>
<br>
--<br>
Simon South<br>
<a href=3D"mailto:simon@simonsouth.net" target=3D"_blank">simon@simonsouth.=
net</a><br>
<br>
<br>
Simon South (7):<br>
=C2=A0 pwm: rockchip: Enable APB clock during register access while probing=
<br>
=C2=A0 pwm: rockchip: rockchip_pwm_probe(): Remove superfluous<br>
=C2=A0 =C2=A0 clk_unprepare()<br>
=C2=A0 pwm: rockchip: Replace &quot;bus clk&quot; with &quot;PWM clk&quot;<=
br>
=C2=A0 pwm: rockchip: Eliminate potential race condition when probing<br>
=C2=A0 pwm: rockchip: rockchip_pwm_probe(): Remove unneeded goto target<br>
=C2=A0 pwm: rockchip: Enable PWM clock of probed device only if running<br>
=C2=A0 pwm: rockchip: Enable clock before calling clk_get_rate()<br>
<br>
=C2=A0drivers/pwm/pwm-rockchip.c | 64 ++++++++++++++++++++++++-------------=
-<br>
=C2=A01 file changed, 40 insertions(+), 24 deletions(-)<br>
<br>
-- <br>
2.29.2<br>
<br>
<br>
_______________________________________________<br>
Linux-rockchip mailing list<br>
<a href=3D"mailto:Linux-rockchip@lists.infradead.org" target=3D"_blank">Lin=
ux-rockchip@lists.infradead.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-rockchip" rel=
=3D"noreferrer" target=3D"_blank">http://lists.infradead.org/mailman/listin=
fo/linux-rockchip</a><br>
</blockquote></div></div></div></div>

--0000000000001b5dac05b744a0dc--
