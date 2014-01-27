From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: lp3943: Fix potential memory leak during request
Date: Mon, 27 Jan 2014 09:58:03 +0000
Message-ID: <20140127095803.GC14478@lee--X1>
References: <20140123223220.7d68b5f6@spike>
 <20140124162302.GA28335@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:55404 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbaA0J6W (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jan 2014 04:58:22 -0500
Received: by mail-wg0-f41.google.com with SMTP id n12so3956487wgh.4
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jan 2014 01:58:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140124162302.GA28335@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Christian Engelmayer <cengelma@gmx.at>, Milo Kim <milo.kim@ti.com>, linux-pwm@vger.kernel.org

On Fri, 24 Jan 2014, Thierry Reding wrote:

> On Thu, Jan 23, 2014 at 10:32:20PM +0100, Christian Engelmayer wrote:
> > Fix a memory leak in the lp3943_pwm_request_map() error handling pa=
th.
> > Make sure already allocated pwm map memory is freed correctly.
> > Detected by Coverity: CID 1162829.
> >=20
> > Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
> > ---
> >  drivers/pwm/pwm-lp3943.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
> > index 8a843a0..a40b9c3 100644
> > --- a/drivers/pwm/pwm-lp3943.c
> > +++ b/drivers/pwm/pwm-lp3943.c
> > @@ -52,8 +52,10 @@ lp3943_pwm_request_map(struct lp3943_pwm *lp3943=
_pwm, int hwpwm)
> >  		offset =3D pwm_map->output[i];
> > =20
> >  		/* Return an error if the pin is already assigned */
> > -		if (test_and_set_bit(offset, &lp3943->pin_used))
> > +		if (test_and_set_bit(offset, &lp3943->pin_used)) {
> > +			kfree(pwm_map);
> >  			return ERR_PTR(-EBUSY);
> > +		}
> >  	}
> > =20
> >  	return pwm_map;
>=20
> Lee, since you took this driver via the MFD tree, would you mind pick=
ing
> up this fix as well?

Everything I have is now in Mainline.

It's best for you to apply it now I think?

> In case you don't have it in your inbox somewhere, you should be able=
 to
> grab it from here:
>=20
> 	http://patchwork.ozlabs.org/patch/313741/
>=20
> In that case:
>=20
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
>=20
> Thierry



--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
