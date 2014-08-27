From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] Patch for pwm backlight driver
Date: Wed, 27 Aug 2014 07:44:40 +0200
Message-ID: <20140827054438.GB15640@ulmo>
References: <D68D4F79CA301E4CB7967E4AF0038407253006A8@DHRNASVXM01.danaher.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:34159 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865AbaH0Foo (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Aug 2014 01:44:44 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so15762955wes.31
        for <linux-pwm@vger.kernel.org>; Tue, 26 Aug 2014 22:44:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <D68D4F79CA301E4CB7967E4AF0038407253006A8@DHRNASVXM01.danaher.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Yang, Robert" <RYang@hach.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the patch. A couple of general comments before I get to the
patch. When sending patches, please follow the process explained in
Documentation/SubmittingPatches. In addition, I suggest you use git to
make that process easier. Once you've committed a change and written up
a proper changelog you can use git format-patch to generate the patch
and send it out using git send-email. Also before sending it, you should
run the patch through scripts/checkpatch.pl and make sure there are no
warnings or errors. Then use scripts/get_maintainer.pl to generate a
list of people and lists to Cc. I'm on that list and so is the linux-pwm
mailing list, which is good, but you should additionally Cc the
backlight maintainers (Lee, Bryan and Jingoo). It's usually not
necessary to Cc Linus on a patch directly. It'll get reviewed and
applied to a subsystem tree which will then be sent to Linus during the
merge window along with any other patches applied to that tree.

The commit message should start with a short subject line that explains
very roughly what the commit does. It's also common to prefix it with a
short string that identifies it as belonging to a given subsystem or
driver. Looking at git log -- path/to/modified/file is often a good way
to determine the proper prefix. The subject line should be followed by a
more verbose description of the problem and how it is solved by the
patch.

Also, please wrap email at around 78 characters to increase readability.

A few more comments inline.

On Tue, Aug 26, 2014 at 09:14:07PM +0000, Yang, Robert wrote:
> Hi Thierry,

A commit message doesn't need this.

> Attached is a patch which will fix a bug in the video/pwm backlight
> driver if multiple pwm chips exist. The defect could cause the

Please use PWM in text, since it's an abbreviation.

> backlight driver use the wrong pwm chip and fail finally and also lock
> up the unattended pwm.

What does "lock up" mean?

> The patch will allow a deferral pwm backlight probing if the attended
> pwm driver is not loaded yet.

> This patch is currently against a linux 3.16 kernel.

It's often better to base patches off the latest release candidate,
which in this case is v3.17-rc1, or even the subsystem tree that feeds
into linux-next or linux-next itself. That avoids possible conflicts
with other people's patches. In this case I think 3.16 is fine since
there hasn't been any other work on this driver that I'm aware of.

> The technology in this patch is architecture-independent.

The majority of patches are architecture independent, so there's usually
no need to say this.

> Please let me know any feedback you have on this patch or the approach us=
ed.
>=20
> Thanks,
>=20
>=20
> Signed-off-by: Robert Yang <ryang@hach.com>
>=20
> Robert Yang | Sr. Software Engineer
> P 970.6631377 ext 2626
> Hach Company | www.hach.com<http://www.hach.com/> |ryang@hach.com<mailto:=
|email@hach.com>
>=20
> Water analysis has to be right. You deserve complete solutions you can be=
 fully confident in. Hach is your resource for expert answers, outstanding =
support, and reliable, easy-to-use products.

The above signature doesn't belong in a patch. Your commit message
should end after the Signed-off-by: line.

> --- linux-linux-3.16/pwm_bl.c.orig              2014-08-26 14:26:02.21058=
0989 -0600
> +++ ./linux-linux-3.16/drivers/video/backlight/pwm_bl.c   2014-08-26 14:2=
6:45.318582726 -0600
> @@ -281,15 +281,9 @@ static int pwm_backlight_probe(struct pl
>                pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
>               if (IS_ERR(pb->pwm)) {

The patch here seems whitespace damaged. This could be due to the email
system that you're using. Can you find out why that's happening and make
sure the email infrastructure doesn't do this? As it is, this patch
cannot be applied automatically and I (or someone else) would have to
manually make the changes, which is both tedious and error prone.

> -                             dev_err(&pdev->dev, "unable to request PWM,=
 trying legacy API\n");
> +                            dev_err(&pdev->dev, "unable to request PWM, =
trying a deferral binding later\n");
>                              ret =3D PTR_ERR(pb->pwm);

There are other errors for which it is legitimate to use the legacy code
path here. For the case that you're trying to fix there should probably
be a check here for -EPROBE_DEFER. Somewhat like this:

	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
	if (IS_ERR(pb->pwm)) {
		if (PTR_ERR(pb->pwm) =3D=3D -EPROBE_DEFER)
			goto err_alloc;

		...
	}

Also there's no need for the "... trying deferral binding later" error
message in this case, since returning -EPROBE_DEFER will cause the
driver core to print out such a message already.

> -
> -                             pb->pwm =3D pwm_request(data->pwm_id, "pwm-=
backlight");
> -                             if (IS_ERR(pb->pwm)) {
> -                                            dev_err(&pdev->dev, "unable =
to request legacy PWM\n");
> -                                            ret =3D PTR_ERR(pb->pwm);
> -                                            goto err_alloc;
> -                             }

Like I said, this code path is still required to support old systems
that haven't been converted to use PWM lookup tables yet. There are only
very few of those left, but we cannot remove this code yet.

> +                            goto err_alloc;
>               }
>                dev_dbg(&pdev->dev, "got pwm for backlight\n");
>=20
> Please be advised that this email may contain confidential information. I=
f you are not the intended recipient, please notify us by email by replying=
 to the sender and delete this message. The sender disclaims that the conte=
nt of this email constitutes an offer to enter into, or the acceptance of, =
any agreement; provided that the foregoing does not invalidate the binding =
effect of any digital or other electronic reproduction of a manual signatur=
e that is included in any attachment.

This "disclaimer" is useless in email that goes to a public mailing list
so it should just be removed.

Thierry

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/XBGAAoJEN0jrNd/PrOhz/YP/AmcJLlATh+tbvNWzUuW3xRV
nrQ3xT50FghDR+WRcjcg/hfB/4OiRaLGn9GHnUu4BWc3jHYmkCFkDkB2FCRJ2hqI
Y21e5K6fWBBJEKlbq+e/CDIzDbiHClK95P8SE/groz/bgIDP29RJNEH7pVuiGHbL
NvDvz17WA+aF5kodqkCTYikbUsgoG269qjjYLg43ia1cQSld6fpiqJd9LgCuGxKz
Ntb7LKJpxgluaPYPimYKnIcQauTBSyo/w75cphYbT2VQC7K6RVWl1ElvVizbq4pw
byAmfL36V8rxHkyB4A4iiNPXZoaRda3nX4G9SHYWKfBwxRnlMWAvEFC6C5vhdu6C
5UQnLlCeXAUkb12gU0o/DcSr6sLAhsDmjSW0ZMiZlIy9iL8keCODtpYy3y13tD1f
O8XIon9LHuB5+RtbUNzThb44czXRrckTTB04iIwwaXTEYWBNKPJlmqdi1bEJLA8D
SZsZXGzxmxWlY7mmGuRPztZHpFBxWYQ/n8+30OOqdwyxPIfkRl/L6vVUanPa/4rW
iwUv5TEAOmPx+C+D4r10uXHGemJIXBgv1RNJ+4YavdL7/uscMzGTrFZYrJ+Pb3BA
jZygnsB8QKtITKZYggWOVF2B+iN3C/wru1ijdBJjFZlmmtgAcrNa00uTlnp3PRpb
KcNCuTMnFa5Nn6cm3Jjn
=8m+k
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
