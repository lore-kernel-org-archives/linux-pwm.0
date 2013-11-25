Return-Path: <broonie@sirena.org.uk>
Date: Mon, 25 Nov 2013 15:37:33 +0000
From: Mark Brown <broonie@kernel.org>
Message-ID: <20131125153733.GE14725@sirena.org.uk>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
 <20131125031029.GC11613@S2101-09.ap.freescale.net>
 <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Dz7ZkHOyZKsJidB"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
List-ID: <linux-pwm.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org


--9Dz7ZkHOyZKsJidB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2013 at 11:26:53AM -0200, Fabio Estevam wrote:

> linux-next 20131120: backlight fails
> linux-next 20131122: backlight works
> linux-next 20131125: backlight fails

What are the differences between those kernels?  I'm not aware of any
regulator core changes at all there and diff isn't showing me any - are
you sure you used a consistent kernel configuration?  Have you tried to
look at what happens when we should provide the dummy regulator, and do
the logs say anything?

> Looks like we need to apply this one to make sure backlight works:
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/281826

Please always provide plain text versions of links and SHA1s...  that
link is to a patch adding a fixed regulator which you should do but
ought not to need to do.

--9Dz7ZkHOyZKsJidB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSk266AAoJELSic+t+oim9dmgQAIvNbiutlfJAUitFRi1FDmfK
MWQjPQE03CWShwTfarWGBO6C+Q/wlQJNHhM8KFhbYt2HCHNkG+lnAJG6rtLNjl6A
xVnVnldO7V+KvNc44MV+AkdnouHFEVH14ZBTlxz06RJy8nsl7biI6+62cUsai/ux
zzTnZpO9yi4kcITBxb0b8eC1F/KEySUoZexB+dvz9ck65OVJHXQOOOeKbWO5zFsm
0hTvkFbQ5c9rfYiWdLbcB+RO4TI8AZbH6zGwDuu+SKgFNlHfnHcRyUKGhnP7DM9D
eh7iMt/cMUZpLERIL/Lv7AI89K6lDnCd0vKkpY1T92Ffzs8CfURMYKy4JoWmEFgv
xsYYI/bqsZ6eq107sTmA+wcKabwqk6Fo/qjkRlB4aFCJzLxcuZDK5VgBObkMTHCQ
Z1Twy5jwdk040+UCfNCylh4ioSjJWj9OR6eMZPCpi7W8gbULQ1L10UnEpQ8dIHG8
j8tvR3EGAHa4ZadFujRA/8C8MeRVCKXAMsPJil00Gyfw1WOI596Y67SHLVHbqcGU
QqPu5eGSCUd2jIjf//jm3hmLeVPrcvRlkGmnwsH4KG3DtwieStXjAwSLm09gPYrn
HXxpLJ0nvYmGpF7xkKt/Eafl7HQReyShwhPBnuAbDXJm8yoS2RMpxCVSvPGblG8G
oR6XouNcDKpzncSKc68l
=ajX8
-----END PGP SIGNATURE-----

--9Dz7ZkHOyZKsJidB--
