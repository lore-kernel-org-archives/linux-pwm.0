From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Lee Jones as reviewer for the PWM
 subsystem
Date: Wed, 3 Jun 2020 16:42:24 +0200
Message-ID: <20200603144224.GC3478467@ulmo>
References: <20200602123241.3363904-1-thierry.reding@gmail.com>
 <20200603123718.6fwsbpnkbjlpq2bz@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgFCOma (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Jun 2020 10:42:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832A7C08C5C0
        for <linux-pwm@vger.kernel.org>; Wed,  3 Jun 2020 07:42:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l1so1954848ede.11
        for <linux-pwm@vger.kernel.org>; Wed, 03 Jun 2020 07:42:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200603123718.6fwsbpnkbjlpq2bz@taurus.defre.kleine-koenig.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2020 at 02:37:18PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jun 02, 2020 at 02:32:41PM +0200, Thierry Reding wrote:
> > Lee has kindly offered his help in sharing the patch review workload for
> > the PWM subsystem. If this works out well between Lee, Uwe and myself it
> > may be a good idea to maintain the subsystem as a group.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e64e5db31497..b8889bed5d1e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13736,6 +13736,7 @@ F:	drivers/media/rc/pwm-ir-tx.c
> >  PWM SUBSYSTEM
> >  M:	Thierry Reding <thierry.reding@gmail.com>
> >  R:	Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > +M:	Lee Jones <lee.jones@linaro.org>
>=20
> I'm bit surprised that Lee got M: which I have a R:. The commit log
> talks about reviewer not maintainer.
>=20
> While I'm not sure that there is a practical difference it makes me a
> bit sad.

That was not the intention. According to the notes at the top of the
MAINTAINERS file, recipients on M: lines will be added in the To:
header, while R: lines will be added in the Cc: header. That's really
the only difference.

In practical terms this may be helpful for filtering where email where
you are on the To: line can be prioritized over those where you are on
the Cc: line.

Thierry

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Xts4ACgkQ3SOs138+
s6H5yxAAmYmqQwuGzDPqrkstA5uFYK1PpEb/Rwl0I72v0EBXWO7yGhjPLUKZxV/S
hC89YYptJO25e4Nb1Q4/DlLBaE2KY3sfwOJzZAE8/jNsetz08qvsCUQNsVz0pPPz
PbYMY+ZyfyuWtM1mQKg1ELQtIQaMEUqaBAmf2ET+9ofB4zpFHLhP+LV/CSX4eBjo
O7y676kzt6Myyk7YaGtj+AwK2duG7MGM71ZLuEyE3ftQS1otd7Fk3Ieitv5uaBJZ
/RUzE6ZmdNbmR9K2xLLLn6TrCxz5LnMEyQletOliwH+Pszsxx+4n8lzMJEB9tHie
nmRXqQvOZBw4zoG8JEH8ASmaUGb332wVGYqW7Y+m0U4/iDvC1brsp6h1fBGYPl8N
TJdz52OUO4tsEtex0s53AgbMViq62Dexsvm0BHxHlkLjfJ76lqcCj6BU/fzmLXrw
SNxpr74tdbjKO/eG+hoRYx9A7cE440GrMa5M6FcMRszavf/EzJE8/1V+FOHtlqg7
qWBmwh44daW+lrWGW/xnbZ+o6fKxInFvPkROQVC3vK9kb/8vH+oTeY1WS+p309QW
VJRv5h2o3H1V2ef2Sjv6BMHGdSAb5vLwhqQQMaAe6s1idUbZvaMtpf+VS4ojJqb9
NVhmJGS5yjSnHLZY6mGtzBK7Lrp/ccxmSuhgUl+MksiylwYnVN4=
=3aFz
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
