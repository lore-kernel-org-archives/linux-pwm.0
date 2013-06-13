Return-Path: <heiko@sntech.de>
From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 00/15] Final Samsung PWM support cleanup
Date: Thu, 13 Jun 2013 22:17:43 +0200
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com> <51B909A5.2020409@gmail.com> <1808375.nuQYa2FdfG@flatron>
In-Reply-To: <1808375.nuQYa2FdfG@flatron>
MIME-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201306132217.44265.heiko@sntech.de>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

Am Donnerstag, 13. Juni 2013, 11:07:38 schrieb Tomasz Figa:
> Hi Heiko, Sylwester,
>=20
> On Thursday 13 of June 2013 01:52:05 Sylwester Nawrocki wrote:
> > On 06/13/2013 01:38 AM, Heiko St=EF=BF=BDbner wrote:
> > > Am Donnerstag, 13. Juni 2013, 01:13:47 schrieb Tomasz Figa:
> > >> Hi Olof,
> > >>=20
> > >> On Wednesday 12 of June 2013 16:00:23 Olof Johansson wrote:
> > >>> On Wed, Jun 12, 2013 at 11:48:56PM +0200, Tomasz Figa wrote:
> > >>>>> Needs testing on other platforms as I could only compile test for
> > >>>>> them.
> > >>>=20
> > >>> How/who can help here? WHo has and still cares for other affected
> > >>> platforms?
> > >>>=20
> > >>>>> 66 files changed, 627 insertions(+), 1580 deletions(-)
> > >>=20
> > >> I will try to test this on Exynos 4 at work, if I somehow manage to
> > >> find any way to use PWM on our boards (other than already-tested PWM
> > >> clocksource).
> > >>=20
> > >> Unfortunately, except S3C6410, I don't have access to other
> > >> platforms, or at least I won't in any reasonable time.
> > >>=20
> > >> If I remember correctly, in case of my watchdog support cleanup,
> > >> Kukjin
> > >> has been able to test it on S5P64x0.
> > >>=20
> > >> Heiko and Sylwester used to have some s3c24xx-based boards, not sure
> > >> if
> > >> they still do and are interested in their support in mainline.
> > >>=20
> > >> So all left is S5PC100 (for which I couldn't find anyone who cares)
> > >> and
> > >> Exynos5.
> > >>=20
> > >>> Nice cleanup.
> > >>=20
> > >> Thanks.
> > >>=20
> > >>>> Any comments for this series?
> > >>>=20
> > >>> Yes, above. :) In general looks good -- testing coverage is a bit of
> > >>> a
> > >>> concern.
> > >>=20
> > >> Yeah. Unfortunately all I could do was testing on Tiny6410 and
> > >> compile
> > >> testing on others. I hope we find some really helpful people over
> > >> here who could waste a bit of their precious time for this museum.
> > >> ;)
> > >=20
> > > I'll try to give it a testrun tomorrow. And my s3c2416 will always be
> > > the first-love-architecture for me ;-)
> >=20
> > I'll likely test it tomorrow on a Mini2440 board, I was going to do it
> > earlier
> > but got distracted by plenty other things that needed attention too. At
> > least
> > that's one of the reasons I got the board - testing the cross-platform
> > cleanups
> > and ensuring they are not breaking the older platforms.
>=20
> Thank you both for your support. Looking forward for testing results :)


on a s3c2416-based machine for dt and non-dt case
[with the limit that my machine does not has anything connected to the pwm =

outputs, so I only get to test the base-pwm and timer part]

Tested-by: Heiko Stuebner <heiko@sntech.de>
