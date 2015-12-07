From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5] pwm-backlight: Avoid backlight flicker when probed
 from DT
Date: Mon, 7 Dec 2015 09:35:07 +0000
Message-ID: <20151207093507.GA3384@x1>
References: <1447866745-21567-1-git-send-email-p.zabel@pengutronix.de>
 <20151124162658.GJ807@x1>
 <CAGS+omCD3MLB+hf4R1aD+YZuB4SV8nu71oAm6V_bkfoE2im49A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGS+omCD3MLB+hf4R1aD+YZuB4SV8nu71oAm6V_bkfoE2im49A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, YH Huang <yh.huang@mediatek.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sasha Hauer <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Mon, 07 Dec 2015, Daniel Kurtz wrote:

> Hi Lee,
>=20
> On Wed, Nov 25, 2015 at 12:26 AM, Lee Jones <lee.jones@linaro.org> wr=
ote:
> > On Wed, 18 Nov 2015, Philipp Zabel wrote:
> >
> >> If the driver is probed from the device tree, and there is a phand=
le
> >> property set on it, and the enable GPIO is already configured as o=
utput,
> >> and the backlight is currently disabled, keep it disabled.
> >> If all these conditions are met, assume there will be some other d=
river
> >> that can enable the backlight at the appropriate time.
> >>
> >> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> >> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> >> Tested-by: Heiko Stuebner <heiko@sntech.de>
> >> ---
> >>  - Rebased onto v4.4-rc1
> >>  - Added Heiko's Tested-by
> >> ---
> >>  drivers/video/backlight/pwm_bl.c | 23 ++++++++++++++++++++++-
> >>  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > Applied, thanks.
>=20
> Hmm, where was this applied?  I do not see it in:
>  * v4.4-rc4
>  * linux-next next-20151203 (dcccebc - Add linux-next specific files
> for 20151203)
>=20
> Nor do I see it in any branch in:
>  * git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
> Is this the right git?

Yes, that's right.  When I say "applied", it means I applied it to my
local repository.  I am careful not to allude to the patch being
"pushed".  There is no guarantee when this will happen, since it
completly depends how busy the subsystem is.  For Backlight, as the
churn is low, the impetus for pushing is pretty low.

It has been "pushed" now though.

> By the way this repository has a git tag called "HEAD", which is a bi=
t
> annoying since every time I "git remote update" from here, git gets
> confused until I manually delete it (git tag -d HEAD).

Thanks for letting me know.  I have now removed this tag.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
