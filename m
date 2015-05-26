Return-Path: <gael.portay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1432570309-17819-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432559996-4415-2-git-send-email-alexandre.belloni@free-electrons.com>
	<1432570309-17819-1-git-send-email-alexandre.belloni@free-electrons.com>
Date: Tue, 26 May 2015 12:03:41 +0200
Message-ID: <CAHs7_BZ=gpb9QvfcYxFo+xCrks-XcdSGa-zi_HOxmp=OOX+Y7Q@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] PWM: atmel: fix incorrect CDTY value after disabling
From: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
Content-Type: multipart/alternative; boundary=047d7b4724d8b8f0960516f93db3
List-ID: <linux-pwm.vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

--047d7b4724d8b8f0960516f93db3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25 May 2015 at 18:11, Alexandre Belloni <
alexandre.belloni@free-electrons.com> wrote:

> I had the previous patch tested on a multicolor LED and unfortunately, th=
e
> delay
> is not nice in that case. I wanted to avoid a mutex.
> This version uses a variable to store the state of the update of the pwm.
> This
> is reset everytime is gets a new configuration and updated when it is
> disabled
> or another pwm is configured.
>

This version (including a mutex) works fine on at91-kizbox2.

All tree PWM LEDs now shut down.


> When disabling a multicolor LED, we only wait for the first pwm to update
> then
> we remember that we already seen the other one having their period expire
> and it
> looks much better.
>

Indeed, without mutex (and with a long period), I noticed a kind of
"glitch" when I switch off all 3 LEDs: White ->
Red|Blue|Green|Yellow|Cyan|Magenta -> Off.

With the mutex, all 3 LEDs shut down at the same time.

Tested-by: Ga=C3=ABl PORTAY <gael.portay@gmail.com>

--047d7b4724d8b8f0960516f93db3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div><div><div><div><div><div class=3D"gmail_extra"><d=
iv class=3D"gmail_quote">On 25 May 2015 at 18:11, Alexandre Belloni <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:alexandre.belloni@free-electrons.com" targ=
et=3D"_blank">alexandre.belloni@free-electrons.com</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">I had the previous patch=
 tested on a multicolor LED and unfortunately, the delay<br>
is not nice in that case. I wanted to avoid a mutex.<br>
This version uses a variable to store the state of the update of the pwm. T=
his<br>
is reset everytime is gets a new configuration and updated when it is disab=
led<br>
or another pwm is configured.<br></blockquote><div><br>This version (includ=
ing a mutex) works fine on at91-kizbox2.<br><br>All tree PWM LEDs now shut =
down.<br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
When disabling a multicolor LED, we only wait for the first pwm to update t=
hen<br>
we remember that we already seen the other one having their period expire a=
nd it<br>
looks much better.<br></blockquote><div><br><div>Indeed, without mutex (and=
 with a long period), I noticed a kind of &quot;glitch&quot; when I switch =
off all 3 LEDs: White -&gt; Red|Blue|Green|Yellow|Cyan|Magenta -&gt; Off.<b=
r><br></div><div>With the mutex, all 3 LEDs shut down at the same time.<br>=
</div><div><br></div><span class=3D"">Tested</span>-<span class=3D"">by</sp=
an>: <span class=3D"">Ga</span>=C3=ABl PORTAY &lt;<a href=3D"mailto:gael.po=
rtay@gmail.com" target=3D"_blank">gael.portay@gmail.com</a>&gt;<br></div></=
div><br></div></div></div></div></div></div></div>

--047d7b4724d8b8f0960516f93db3--
