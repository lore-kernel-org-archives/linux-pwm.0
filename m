From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Date: Wed, 10 Oct 2018 15:51:09 +0200
Message-ID: <20181010135109.GE21134@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Atish Patra <atish.patra@wdc.com>
Cc: palmer@sifive.com, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, hch@infradead.org
List-Id: linux-pwm@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
[...]
> +- interrupts: one interrupt per PWM channel (currently unused in the driver)

This should probably say what the interrupt is used for. And once you
have that, remove the comment about it being unused in the driver. DT
is OS agnostic, so "driver" is very unspecific and your claim may
actually be false.

Thierry

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu+A80ACgkQ3SOs138+
s6Em+A//YNUERpXON1hDSTruvUjUYuyLVi7AhJJCbc+1AadlHjGwaLrId2I1Tjy0
3QoZUDLbpHx9hzzH9wYy7XoCQQsL6HVxEhImolxeeUli89A9SBW0zpPWXayYWdtA
k+fsVgAPYEiEjuqtvfxjCc6MLpIosC+WJa8GB0WpxB5vFC5BzvDwB7xDOr10hETO
Pw2dKKjmWjG3WYV2jk7Vx7W/qJDOoK16D3VyXgkxwg1YfKRGsZAiAGIC6IREFiFj
EFGxaGXDfn3tpoP2qUrnCBFAfwUAZ35GT7c+yjpiQKhRnUhv9y3M4dm1xEJT5FG4
oGhWb8ZAN/dejJf3QuIX53uD09qdqJ2/hfvO5YPYDa7S/5qIYJt9DXl9h/aMNjB9
HkGMFRRwmh/LaZYE06clCIayuYOwDpLtmbXhn8E9+QtxIR1PRXBTK7V8bsR0unvN
pREDxvjSRvDxTSH7sNxADnEouktJlhKCfl1iZ/rMw+9TavqkgIxD60+CvIlp2gnd
cYvEUDkqvLEAHenkICplYiIO7EgVPF36GLdy4UoS+Lp8zIHKfQa6ReCZTPiJGux4
pGx6NOojw9tGhf9F+SR8QLIVbEHKzNbdvXafV2QMmKlOpLnoOMmgSapXdETznHM4
sJKEO82dlN0kQ7uv/wV4wO6RGmXzHNdkSvngHsRrob6+yfPWRdg=
=osbe
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
