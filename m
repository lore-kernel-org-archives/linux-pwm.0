Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 00/15] Final Samsung PWM support cleanup
Date: Thu, 13 Jun 2013 01:13:47 +0200
Message-ID: <1604160.oAKkaEhla1@flatron>
In-Reply-To: <20130612230023.GA9016@quad.lixom.net>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com> <1444953.LmSrOvSyJG@flatron> <20130612230023.GA9016@quad.lixom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

Hi Olof,

On Wednesday 12 of June 2013 16:00:23 Olof Johansson wrote:
> On Wed, Jun 12, 2013 at 11:48:56PM +0200, Tomasz Figa wrote:
> > > Needs testing on other platforms as I could only compile test for
> > > them.
> 
> How/who can help here? WHo has and still cares for other affected
> platforms?
> > > 66 files changed, 627 insertions(+), 1580 deletions(-)

I will try to test this on Exynos 4 at work, if I somehow manage to find 
any way to use PWM on our boards (other than already-tested PWM 
clocksource).

Unfortunately, except S3C6410, I don't have access to other platforms, or 
at least I won't in any reasonable time.

If I remember correctly, in case of my watchdog support cleanup, Kukjin 
has been able to test it on S5P64x0.

Heiko and Sylwester used to have some s3c24xx-based boards, not sure if 
they still do and are interested in their support in mainline.

So all left is S5PC100 (for which I couldn't find anyone who cares) and 
Exynos5.

> Nice cleanup.

Thanks.

> > Any comments for this series?
> 
> Yes, above. :) In general looks good -- testing coverage is a bit of a
> concern.

Yeah. Unfortunately all I could do was testing on Tiny6410 and compile 
testing on others. I hope we find some really helpful people over here who 
could waste a bit of their precious time for this museum. ;)

Best regards,
Tomasz
