From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: Fix default PWM polarity
Date: Tue, 17 May 2016 13:00:05 +0200
Message-ID: <20160517110005.GA26166@ulmo.ba.sec>
References: <1463476352-7485-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35866 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbcEQLAJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2016 07:00:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so3726799wmw.3
        for <linux-pwm@vger.kernel.org>; Tue, 17 May 2016 04:00:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1463476352-7485-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2016 at 11:12:32AM +0200, Boris Brezillon wrote:
> The PWM device exposed by the HLCDC IP is configured with an inverted
> polarity by default. Registering the PWM chip with the normal polarity
> was not a problem before commit 42e8992c58d4 ("pwm: Add core
> infrastructure to allow atomic updates") because the ->set_polarity()
> hook was called no matter the current polarity state, but this is no long=
er
> the case.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Fixes: 42e8992c58d4 ("pwm: Add core infrastructure to allow atomic update=
s")

That's not technically correct, because it's the driver that has the
bug. The core change merely exposes it. How about if I sort this into
the pwm-atomic branch and reword the commit message accordingly? That
way things should all stay bisectible.

Then again, given the breakage caused by the pwm_args patch I suppose
it doesn't matter much because that's part of a stable branch that I
can't rebase.

Thierry

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXOvmyAAoJEN0jrNd/PrOhbesP/0Ct7ja8gjPvbGr6nbVGcL2u
fwQSjRpGN2Ym1Gl+/CclpqkIMpG4hOd0IvlerdkZbAZYpjcU3rwmeJddPzuRHTJ1
zseU07cRIYhIg8rw2vZ81e9U4wjgK2s7wnh7gmPJYDsfinyCxDsBXjqbOOhtt3ru
lThqWRC+kWENbY1QoGVaUNnJ5FRlVBYewf43MuYw8+Ko41ScstF1nCbJqNvjrIoO
EHJr9A82ckLZpg1uF+DZxkBFc7toW5/qDhE9zt6AcLCE0qeOTFHCJjBpVVMeTHdB
Ed+nZ9khamRb8ym38CL9a/NjN/qTVf/ClBLA3f9UZRpHQqcn3ERRAd5E63QKnGtF
97mrIaZDLaGPh47J1uG2iJvvX+6x7y8NMY7aIRK8Wptcf4tY5ILFQ3ZxbtvWjjB4
Adcm9QZvxMwn5Q3dDwd4Q7lxuvKpMbDQlJ8Fb90cLfjcgBCBWv8uEGFPmkbhs662
B2mF7DG4pl6UBIsi5w4ALe1R9UI12+hx/JtFtfEh90Ul4XpRhCn8CEzKpDou7Jav
mbUw0OKf+SLCcJ+p88OvpAdsmg8DIiYXJ3M3ZTpYnuXtbei95g4vBqfeewvmj+Sb
ekhkGPADyovMvQzTluZMrvxqZR/J0me5rKAWVSiJWjvbqiAFDjSmiDpUg0Bq9RrP
mp/bf0G6lfKrbc6uum24
=OTW/
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
