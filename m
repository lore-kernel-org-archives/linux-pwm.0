From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: img: Impose upper and lower timebase steps value
Date: Tue, 19 May 2015 16:15:24 +0200
Message-ID: <20150519141522.GA26748@ulmo.nvidia.com>
References: <1431035961-2008-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1431121651-6787-1-git-send-email-ezequiel.garcia@imgtec.com>
 <555778D3.4030607@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33676 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933063AbbESOP3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 19 May 2015 10:15:29 -0400
Received: by pdbqa5 with SMTP id qa5so27374438pdb.0
        for <linux-pwm@vger.kernel.org>; Tue, 19 May 2015 07:15:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555778D3.4030607@imgtec.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: linux-pwm@vger.kernel.org, Naidu Tellapati <naidu.tellapati@imgtec.com>, James Hartley <james.hartley@imgtec.com>, linux-mips@linux-mips.org, sai.masarapu@imgtec.com, arul.ramasamy@imgtec.com


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2015 at 02:05:23PM -0300, Ezequiel Garcia wrote:
> Thierry,
>=20
> On 05/08/2015 06:47 PM, Ezequiel Garcia wrote:
> > From: Naidu Tellapati <naidu.tellapati@imgtec.com>
> >=20
> > The PWM hardware on Pistachio platform has a maximum timebase steps
> > value to 255. To fix it, let's introduce a compatible-specific
> > data structure to contain the SoC-specific details and use it to
> > specify a maximum timebase.
> >=20
> > Also, let's limit the minimum timebase to 16 steps, to allow a sane
> > range of duty cycle steps.
> >=20
> > Fixes: 277bb6a29e00 ("pwm: Imagination Technologies PWM DAC driver")
> > Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> > ---
> > This patch is needed for the pwm-img to work properly, so it should be
> > pushed as a v4.1-rc fix.
> >=20
>=20
> Any chance you push this patch as a fix for v4.1?

Pull request sent now. In the future it'd be nice to make fix patches
smaller than this and leave the refactoring to a subsequent patch for
inclusion in the next release.

Thierry

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVW0V6AAoJEN0jrNd/PrOhQGgQAJGYD2A22jeo0k75oqqRX+1t
mjjroNeQMGZ40qto3h9WWz7EdtZzCKmPwERUNq40JHcfkoix4eq2nkHm55+WD1F0
/eGsnZo3et+Qi+HAB5Myo0IInL1YQZwioxhOjCdAoL5cZkIgtjindIN1LvElhOMi
dukWUiQTVffgkc7MLIUZpEeYIIgwjpYEbLBbO3uew0V/+JE5S2umKveZ5y+HfiCM
Gwp/cN2f795A3W3t8xBvPFkbhFjpHenlk2AnVqtSoaBMqf9gX78qLUKFwB2Gg72T
5utd4TqDYhZYHyU6EkuABehysdPqZawImh/CZ+d8XnfXfpwcUeMXIBDhLQINHQf9
xyL2rlvRr5X4NYK9grBUk/VV3dEUnNY4CQ2A/1cAitymZzrjq+77AiMwTXzSu/GZ
a1GXBRM4CNbRP6G/YkJYgHq0G3BpzccmxpxMOWxbd6nncDNaFbdp3X/Q3TPve6Sr
K4cs2s/ANUzfba81Xfdlr+HP6T2tsTCp1UZXioyB2ozbUF4XutBysb8sYMhHtkJc
oc0TLFjT3PBMo0OyQZh1K6R5kH4wFb+JVatLui89pOAC3qJv9BXxtA11wiq61F72
/gP+5kDmW0x+NiQguxGniJYk7zZ+B60EEmjdizxbrdJTpDUYJthrZlKO/0qIqFob
lI6nrrXABFMgrTAl+xPk
=4kM+
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
