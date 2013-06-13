Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 00/15] Final Samsung PWM support cleanup
Date: Thu, 13 Jun 2013 11:07:38 +0200
Message-ID: <1808375.nuQYa2FdfG@flatron>
In-Reply-To: <51B909A5.2020409@gmail.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com> <201306130138.05692.heiko@sntech.de> <51B909A5.2020409@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-pwm.vger.kernel.org>
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

Hi Heiko, Sylwester,

On Thursday 13 of June 2013 01:52:05 Sylwester Nawrocki wrote:
> On 06/13/2013 01:38 AM, Heiko St=FCbner wrote:
> > Am Donnerstag, 13. Juni 2013, 01:13:47 schrieb Tomasz Figa:
> >> Hi Olof,
> >>=20
> >> On Wednesday 12 of June 2013 16:00:23 Olof Johansson wrote:
> >>> On Wed, Jun 12, 2013 at 11:48:56PM +0200, Tomasz Figa wrote:
> >>>>> Needs testing on other platforms as I could only compile test f=
or
> >>>>> them.
> >>>=20
> >>> How/who can help here? WHo has and still cares for other affected=

> >>> platforms?
> >>>=20
> >>>>> 66 files changed, 627 insertions(+), 1580 deletions(-)
> >>=20
> >> I will try to test this on Exynos 4 at work, if I somehow manage t=
o
> >> find any way to use PWM on our boards (other than already-tested P=
WM
> >> clocksource).
> >>=20
> >> Unfortunately, except S3C6410, I don't have access to other
> >> platforms, or at least I won't in any reasonable time.
> >>=20
> >> If I remember correctly, in case of my watchdog support cleanup,
> >> Kukjin
> >> has been able to test it on S5P64x0.
> >>=20
> >> Heiko and Sylwester used to have some s3c24xx-based boards, not su=
re
> >> if
> >> they still do and are interested in their support in mainline.
> >>=20
> >> So all left is S5PC100 (for which I couldn't find anyone who cares=
)
> >> and
> >> Exynos5.
> >>=20
> >>> Nice cleanup.
> >>=20
> >> Thanks.
> >>=20
> >>>> Any comments for this series?
> >>>=20
> >>> Yes, above. :) In general looks good -- testing coverage is a bit=
 of
> >>> a
> >>> concern.
> >>=20
> >> Yeah. Unfortunately all I could do was testing on Tiny6410 and
> >> compile
> >> testing on others. I hope we find some really helpful people over
> >> here who could waste a bit of their precious time for this museum.=

> >> ;)
> >=20
> > I'll try to give it a testrun tomorrow. And my s3c2416 will always =
be
> > the first-love-architecture for me ;-)
>=20
> I'll likely test it tomorrow on a Mini2440 board, I was going to do i=
t
> earlier
> but got distracted by plenty other things that needed attention too. =
At
> least
> that's one of the reasons I got the board - testing the cross-platfor=
m
> cleanups
> and ensuring they are not breaking the older platforms.

Thank you both for your support. Looking forward for testing results :)=


Best regards,
Tomasz
