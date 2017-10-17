From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v4 7/8] pwm: Add dummy pwmchip for orphan pwms
Date: Tue, 17 Oct 2017 19:46:03 +0100
Message-ID: <20171017184603.yluoukqq6hj2cgcb@sirena.co.uk>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
 <20171017101624.12506-8-jeffy.chen@rock-chips.com>
 <20171017124031.GA27983@ulmo>
 <20171017170428.GB3408@google.com>
 <CAKdAkRRm9aK3KmPTqtD0d1dENyAq7aXrSEjKXZQMXuJin2hoUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ixpvzrnoghzi4x3v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKdAkRRm9aK3KmPTqtD0d1dENyAq7aXrSEjKXZQMXuJin2hoUA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, lkml <linux-kernel@vger.kernel.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>, tfiga@chromium.org, seanpaul@chromium.org, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--ixpvzrnoghzi4x3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 17, 2017 at 11:24:24AM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 17, 2017 at 10:04 AM, Brian Norris <briannorris@chromium.org> wrote:

> > BTW, since you seem to have an opinion about device links: is it
> > expected that all consumer drivers will make explicit calls to
> > device_link_add()? I thought this should be avoided, if possible (e.g.,
> > this can be handled in pwm_get()).

> Ideally we would not have this in core kernel API (pwm_get, gpiod_get,
> regulator_get, etc) but retrieve it form the firmware (device tree,
> ACPI) and use this data not only on suspend/resume but for probing as

Right, the major initial push here was for ordering of probes so doing
it in subsystems or drivers is too late.

> well. *How exactly* can we do that is still not clear though, so maybe
> we could plug the biggest holes by actually adding device links calls
> to the main devm_<object>_get() users...

I would expect we can get a long way in the DT by doing a pass over the
tree and adding links between device nodes in cases where phandle
references exist.  There is a potential issue with circular links which
I'm just going to handwave away right now but I'd expect that to help
otherwise.

--ixpvzrnoghzi4x3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnmT+sACgkQJNaLcl1U
h9Dzngf+JKGTw8mERo+RhzPUS/+1v7DZS4P70d5lHwixV8mmq5D6ymX56ayRtEAr
eIK8FeKP5cRkQm4+eX4lswBFszNa064pTqH3RJ3v0xmd7y91cW5nKdNwTdtvBFSi
w1XjSce4JcS81CXQgfFGvJDMEIxyI0DE2BxmNEYd/jXxdH+laVSmDS63A9bubF6e
3YRSOvywsazwWchEsgFS8U+Z/q1tf6n3AABRJXO54bQOmPCG4aX4ZczoDDz1sj7f
gaih41cvc5Yh33fvERu74boUH+7qbCb/NvqTgVo9c6E36iIpNDxgu9WT7lTPRel0
HRqjwwIEkOHNxBtblnGhDddznmla9A==
=IVtf
-----END PGP SIGNATURE-----

--ixpvzrnoghzi4x3v--
