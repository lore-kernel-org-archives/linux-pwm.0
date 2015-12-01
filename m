From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/3] pwm: bcm2835: prevent division by zero
Date: Tue, 01 Dec 2015 15:16:20 -0800
Message-ID: <87h9k1yd2z.fsf@eliezer.anholt.net>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com> <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:33997 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208AbbLAXQ3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Dec 2015 18:16:29 -0500
In-Reply-To: <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>
Cc: Remi Pommarel <repk@triplefau.lt>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> It's possible that the pwm clock become an orphan. So better
> check the result of clk_get_rate in order to prevent a division
> by zero.

How would we lose our clock when we're keeping the clock enabled from
driver probe until remove?

Patches 1 and 3 are:

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWXipFAAoJELXWKTbR/J7ofMwP/00AbnlG/qfUqOWxUMutrJYD
lfGasCNTK2LrFCYCLHBq/kW7f4Jviq//MDd4hA42bzicfB8tocamXwn9b/EEOLr6
EwT0v+9qFSI0oXX/nWV9Qwr/K40kbLgKQlnU7NEEus0ryy/PMbW+s268EFp9nElI
E4e/K06EcJaOfZIqUN3Vheb1YhivrDOqGacEcMBXnewsP3sebeoqNjfVFGlGiCUF
NtlQS3bHO2aDUKc/hKsBVE/qcmTSTOGGotOwXOkxgeiulJMO/XgD7n7EBzlLdSgo
vMoqL5PFGVZZxH/nxb4gyiW87C3hhLIeFNXK/to6Rhyj2izEgcrUg3GNp5b0ixAb
3k9ja5SbNlVP64oqHuuANlm9csNQMuMX83TzSdkLA2DRVXNIEH+ZryONKqttNF+7
oYAoMZqH+B6h6z9VcM6cdFIxzReFBkZJHGOJ7fVv0ErLyVU3eFaRmUjvqNrDvxUX
eSsZ2t/j0vEzY+J0YVB0OKtn76efhAPGFmWJ3FbwLDK3MxH3iOeAoCoAN7Xe5c7L
/k4sx1qWo6U3JFnn1L6YfmVm7vlo3KtjzX0aLhukAaCW5+04Kz3SXDNE4lEga0BH
v0ZiMjCiRSQToCGnXQ33bhlHwKmLUG+AoI+YtIAkFvuXO9BAE1B0OMN0Tly8xE/y
tiuRAp23idEY6a5Z/nsW
=NTve
-----END PGP SIGNATURE-----
--=-=-=--
