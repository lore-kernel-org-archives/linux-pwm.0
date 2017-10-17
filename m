From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v4 7/8] pwm: Add dummy pwmchip for orphan pwms
Date: Tue, 17 Oct 2017 20:05:01 +0100
Message-ID: <20171017190501.wa272jreg26tprfo@sirena.co.uk>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
 <20171017101624.12506-8-jeffy.chen@rock-chips.com>
 <20171017124031.GA27983@ulmo>
 <20171017170428.GB3408@google.com>
 <CAKdAkRRm9aK3KmPTqtD0d1dENyAq7aXrSEjKXZQMXuJin2hoUA@mail.gmail.com>
 <20171017184603.yluoukqq6hj2cgcb@sirena.co.uk>
 <20171017185259.GA41348@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="owaldczvnwzxmlos"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171017185259.GA41348@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, lkml <linux-kernel@vger.kernel.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>, tfiga@chromium.org, seanpaul@chromium.org, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--owaldczvnwzxmlos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 17, 2017 at 11:53:01AM -0700, Brian Norris wrote:
> On Tue, Oct 17, 2017 at 07:46:03PM +0100, Mark Brown wrote:

> > I would expect we can get a long way in the DT by doing a pass over the
> > tree and adding links between device nodes in cases where phandle
> > references exist.  There is a potential issue with circular links which
> > I'm just going to handwave away right now but I'd expect that to help
> > otherwise.

> But I didn't think FDTs encoded type info. So you don't really know
> whether a phandle is a phandle -- it's just an int (which happens to
> have a corresponding property in some other node). Are we trusting our
> DT bindings well enough to say that, for example, we know that in any
> given device node, a property like 'pwms' must be a phandle to a PWM
> provider? OK, maybe 'pwms' is a bad example (it's unlikely to get
> reused, and it has a companion '#pwm-cells' property), but grepping the
> DT bindings directory shows a ton of one-off properties that contain
> phandles.

If we're going with the 90% thing we can probably get a long way with a
whitelist of properties, and we'll be able to take that a lot further
with the validatable schemas if they ever happen.

--owaldczvnwzxmlos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnmVFwACgkQJNaLcl1U
h9Dy8gf8DCnpKwKeD0VsIR7U3j1pBpJQjuuchj9DOXxoJvdHOUh5sM4UAAo4OzWc
t+ODUjZwQBkQBOVzNjJ6ieVjWCie4q1F7cvHRwgB6DO3Bz2q6B/ObjnlKiUSAtUE
tk9Jt55CNZTt6uEoGbEqL3spl5GN69M1qQyTLp8uwSLETI/b0xbrgP6nRpTjVP0C
V75jHYzeZDHaijUffFTBz+Nawv5OJAYGx4kh1uKduzFz4Frsd4IESJQPLV/sdUzN
nQF+h52DE+u1TMM59X6FgFB8Q4RXlOcR8/UqRmuL8cyf1dOqQ4dVcOSLvrN6JuaY
CNQ/JTRw7mye5VKqOasF75KVuKfa8w==
=02nX
-----END PGP SIGNATURE-----

--owaldczvnwzxmlos--
