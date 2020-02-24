From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] regulator: pwm: Don't warn on probe deferral
Date: Mon, 24 Feb 2020 16:58:59 +0000
Message-ID: <20200224165859.GJ6215@sirena.org.uk>
References: <20200224144048.6587-1-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200224144048.6587-1-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2020 at 02:40:48PM +0000, Jon Hunter wrote:
> Deferred probe is an expected return value for devm_pwm_get(). Given
> that the driver deals with it properly, there's no need to output a
> warning that may potentially confuse users.

>  		ret = PTR_ERR(drvdata->pwm);
> -		dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);

This then means that there's no way for users to determine why the
driver has failed to instantiate which can be frustrating.  It'd be
better to at least have some dev_dbg() output when deferring so that
there's something for people to go on without having to instrument the
code.

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5UANMACgkQJNaLcl1U
h9BiGAf/ZAVaOOpbqGhitjs7tP8A/g9x/elIDmribdXRTC809OYbjyWsgBPgUqJE
E8WSPABeY9t3f9Ie+fcrkidjuUShoOf7CUoWTRS7dba/BICLSFBo2NWcwBwk56gg
qLeEVL37SL4BkipNJeBSh5pXW4oPqyytURkDPK2+7qz0myDw5DkptO3+2F9LNZuI
Ywl4BGnW3pgSHBU6jgHwTQHvvRZDSjixeIuwuNu/3FkLL3O9HceuSZ3LumxXxP2j
N5EUom2pp9dGhkzMZbw/nS0bZqTrlDKOBNIRdKHtYrglPiHKj8P4w4sEzhNYLgtI
bfK6L0eKoKsFz9d5ju7xTBL7e77/yA==
=uw3Q
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
