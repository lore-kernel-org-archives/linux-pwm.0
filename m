From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lp3943: Fix potential memory leak during request
Date: Mon, 27 Jan 2014 13:51:52 +0100
Message-ID: <20140127125151.GA7058@ulmo.nvidia.com>
References: <20140123223220.7d68b5f6@spike>
 <20140124162302.GA28335@ulmo.nvidia.com>
 <20140127095803.GC14478@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:59025 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbaA0Mv4 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jan 2014 07:51:56 -0500
Received: by mail-bk0-f41.google.com with SMTP id na10so2839928bkb.28
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jan 2014 04:51:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140127095803.GC14478@lee--X1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Christian Engelmayer <cengelma@gmx.at>, Milo Kim <milo.kim@ti.com>, linux-pwm@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2014 at 09:58:03AM +0000, Lee Jones wrote:
> On Fri, 24 Jan 2014, Thierry Reding wrote:
>=20
> > On Thu, Jan 23, 2014 at 10:32:20PM +0100, Christian Engelmayer wrote:
> > > Fix a memory leak in the lp3943_pwm_request_map() error handling path.
> > > Make sure already allocated pwm map memory is freed correctly.
> > > Detected by Coverity: CID 1162829.
> > >=20
> > > Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
> > > ---
> > >  drivers/pwm/pwm-lp3943.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
> > > index 8a843a0..a40b9c3 100644
> > > --- a/drivers/pwm/pwm-lp3943.c
> > > +++ b/drivers/pwm/pwm-lp3943.c
> > > @@ -52,8 +52,10 @@ lp3943_pwm_request_map(struct lp3943_pwm *lp3943_p=
wm, int hwpwm)
> > >  		offset =3D pwm_map->output[i];
> > > =20
> > >  		/* Return an error if the pin is already assigned */
> > > -		if (test_and_set_bit(offset, &lp3943->pin_used))
> > > +		if (test_and_set_bit(offset, &lp3943->pin_used)) {
> > > +			kfree(pwm_map);
> > >  			return ERR_PTR(-EBUSY);
> > > +		}
> > >  	}
> > > =20
> > >  	return pwm_map;
> >=20
> > Lee, since you took this driver via the MFD tree, would you mind picking
> > up this fix as well?
>=20
> Everything I have is now in Mainline.
>=20
> It's best for you to apply it now I think?

Sure, I could do that after -rc1 is released. It's somewhat problematic
because I can't really create a tree that's based on yours before -rc1.
After -rc1 it shouldn't be a problem and this also isn't all that
critical, so sending off another pull request to Linus after -rc1 is
probably what I'll do.

Thierry

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5lZnAAoJEN0jrNd/PrOhqtwQAIsvlvshqagJ4dqCdOuiqk6X
TMqlUqTuKV/i6urIYzjDJoOzFBvrPgT5DhCP5sd/PpqeIYXdBDeZMXO7DApUuDVF
MpiYv36x606BDO4XiRKc+faylRhUlhC7exa83ZXddIa7nOoRugtgpxGHMjG9OOrT
St3nLmnIfTzXjnRFj19GxJfsY5lY2w+B6flZwK1sij2DzW9kpuB29RIB8dB+5a/y
BGlXyJncbtgnH9huRZExHLMtudFDTzoiPN6PjscJc3A3vCFsefiFv2BGjalew8pf
W+A5mplK6CEaWdlGjI+xn9nqySRMIeDtC+hfd7QDAUhYOueVGJUdC0oDYphjoygT
M+C8hnAwlYbKKHDOrs7Yunjch2WAFkUITBuAFB3cNYopnsuAA++WLZp9vUQ5QyGN
LwXX5IgEGkilJ1fB+PUhGGH9QB48gfF7ix5kkOPiPcpo/AwMnKZQS+rgZoemxG8j
dHGjI5ErEz/ax7CUWrRXw8KBQRVBpv6Z/Qpq8WDVHlmVY/FoZ7dMphCTu4WlOVid
pVT5BWRZRdi7CZufRW5QSe1nic33Wf9/t2lSNC2tVlRaL7t1C2+sJ0tA9gIoAaLG
qAS4cGs0oU/5Cig+IXCls4s2H+FL0nwrxv2dJYDHHX9j/2cAtBKMzSnwToo+U+Tu
jjLOyHSnTWRFGaDmFqsP
=pIOm
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
