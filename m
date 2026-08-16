Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239E3B42FE
	for <linux-pwm@vger.kernel.org>; Sun, 16 Aug 2026 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786919617; cv=none; b=dSja1fmRk7R//tvfvq0SK1b6tpJ1bTwB6PtbDPEAVQFtW3NlMwH+vigAk8lQdw0NKJo4PajY54M9JV0mE+DYhoS+SsAez0zoDZXtgXghTtuFamlLcyXT/0SQk5ApvmP64G29EzMdV2XOZAkWM9tlMAWiRzQLBQmMze3dLKxl+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786919617; c=relaxed/simple;
	bh=hFyiLLWfP0pI4GwSwpuI20RUmspX5zuiTZWxRIbzPAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H0P+/UOKCG/spnY0OxxMHUNV7DxobUSMePqTpt5T3az25vlduvyl0eqBiQbMaSPdas/SuXH50ZbWqJ49e4w++0dUxWxiFy6k4dH2nZ9oS9bwg9BJhT06G4ayd29bYfy5p5KaeiviyuOqBm4SLezbpUm2qSR+3pAcErB4JzQUXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nH7aEgue; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nH7aEgue"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49954b88fffso31307235e9.0
        for <linux-pwm@vger.kernel.org>; Sun, 16 Aug 2026 15:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786919612; x=1787524412; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=diNbcxbX2N7R6AbZPHc9AfWYDtGpfQ3337JOZQMMM5s=;
        b=nH7aEgue3ovHIzocy8JXqF2KCDq7EybSm/GC2RFps+jxIfcjxU1EvAZZUmSR4q278x
         5WwQ8z4qXsUNlguYKLIzASz7XHg0T8T20XjR94FJ2tRRWU48aekcNOac3Pmsrgu9RGe7
         uzSyODKO9hHZVxGFi3bNmdwfae2SWY7wsv2MgTWWuiXiTXFzj/0hhEAsgmwOxXTqmMAy
         wnDMwsU2zTjAlIQ2AToey5UOC8d9evSL/6REqSyd7APqOZvhVPvLuO+ghWb/RjlqMTtx
         h5APakALlHOs85oUax/Ul+tP9GqpSGiOez9KE4y9S9pMfv9Lp1pNmp+qqykaTsLSZf0/
         LG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786919612; x=1787524412;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=diNbcxbX2N7R6AbZPHc9AfWYDtGpfQ3337JOZQMMM5s=;
        b=hDGLOnGxHnTvZcYzwhp3CgWWwRRH8/UVoSDVSjgdTe9XtXgdhZpehJ8RI+UoyaQQWD
         xCdlYnvr5YktgXY6sAgn+Q+24xVuleP45ZpUXZxUye0jWMaVneu1SovmH7u3G54g0vuV
         WIHTE1pldI4HIMU50qr1oPMhIk7f356cKrpr73Y/vTXEjn50weSnq3Ja62uTP7m0dEE4
         kVSfHzO5D9B405uoP8oaHUqFd8EMZ8mP0jJpLBLgky6l5DOfshmIRRph0h3YgDoZahzq
         q0Fxe65xWScjdkAsNyUfI0OCqLj7zheOKQ3zR+E2/kx6vSh6Zvk457uq1foI4/MEaBg3
         ICvw==
X-Gm-Message-State: AOJu0Yy6uVprj6DtEooRxOez1kMttWPTI+uvBliwoG0lGfSUWW2EiuFB
	riA4Hkqv5FL+V9GtCp11Sx3FDVW2cNBKlyWnI+5hYUnWV+/VjPWmKtuOZvD6HYqGBZI=
X-Gm-Gg: AR+sD12OEjEjHe1P4ibZY99cb00REYd8m7f+Ux0sf7IR61yZEL/Njt6TIKbgJ+SjIeF
	YJkgXtA98LwpBu8a/82dmAPbqHGCOqDT/TLeWR/qiEEMbj19hXU7iVRPMprn10c7PTX9rDqNIUL
	QskJrH0m+7jeOECvfmFHCFF9GP6fTpl6xiqkPUN3RIMclumoN6c8xA9uENGlEsuVuNU4wLWOKU8
	fz2nAkYQFgyniyHSzP2aI1dmEDMYYqZAsFPQciMvdrSRfllaHsbLIdNyxoSJrrWR8a4szHKvCCs
	aIRS7kv+0n8irJc9qWZ3k8sFx/Z5N0lWFu5lrbYJpkmXwR7tf5n9GTTDI5oTIcl+okqjR2wzPya
	ZgMKMFDdsykZrumic74OesTHjieg9ymx0ZxDTEI07OXPnMODRt1TNef4wZdEpU8mgTo8IS7zBmn
	NXStp5PFREBNIi1dqe9cswSg2uJa/qYrok390IsP7OI97eud7Q7NfBW0y8GOxvn2y/6A==
X-Received: by 2002:a05:600c:1906:b0:499:8467:3f2d with SMTP id 5b1f17b1804b1-499879b611dmr271460715e9.19.1786919611148;
        Sun, 16 Aug 2026 15:33:31 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4998ac6afe7sm143124585e9.3.2026.08.16.15.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 15:33:30 -0700 (PDT)
Date: Mon, 17 Aug 2026 00:33:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for 7.3-rc1
Message-ID: <aoI4RihmFwccNTL3@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pv4kxscp2kaxymhl"
Content-Disposition: inline


--pv4kxscp2kaxymhl
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for 7.3-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-7.3-rc1

for you to fetch changes up to b4e94b0418ad6dbe62b6ca53369159ed3d9f0d8c:

  pwm: th1520: use vertical import style (2026-08-11 06:58:59 +0200)

Most patches were in next for for quite some time, for the two topmost
Rust patches I failed to apply them earlier after they got Michal's
blessing so these were in next only roughly a week.

I don't expect any merge issues, there were no conflicts found in next
and the branch merges fine into your master branch.

Thanks for pulling pwm/for-7.3-rc1 for 7.3-rc1.

Best regards
Uwe

----------------------------------------------------------------
pwm: Changes for v7.3-rc1

A bunch of cleanups---in C and Rust---and  a devicetree and driver
extension for a new SoC variant.

Thanks for Biju Das, Francis Laniel, Guru Das Srinagesh, Markus Elfring,
Mikko Perttunen, Thierry Reding, and Yi-Wei Wang for their changes and
further Alexandre Courbot, Benno Lossin, Chen Wang, Geert Uytterhoeven,
Jon Hunter, Laurent Pinchart, Michal Wilczynski, Mikko Perttunen, and
Rob Herring for valuable review feedback.

----------------------------------------------------------------
Biju Das (1):
      pwm: rzg2l-gpt: Drop unused rzg2l_gpt_chip parameter from rzg2l_gpt_c=
alculate_prescale()

Francis Laniel (1):
      rust: pwm: replace `core::mem::zeroed` with `pin_init::zeroed`

Guru Das Srinagesh (1):
      pwm: th1520: use vertical import style

Markus Elfring (1):
      pwm: Use seq_putc() calls in pwm_dbg_show()

Mikko Perttunen (4):
      pwm: tegra: Prefix driver-local macros and functions
      pwm: tegra: Modify read/write accessors for multi-register channel
      pwm: tegra: Parametrize duty and scale field widths
      pwm: tegra: Add support for Tegra264

Thierry Reding (1):
      dt-bindings: pwm: Document Tegra264 controller

Uwe Kleine-K=F6nig (The Capable Hub) (8):
      pwm: mc33xs2410: Initialize spi_device_id arrays using member names
      pwm: Use named initializers for platform_device_id arrays
      pwm: pxa: Depend on OF and simplify accordingly
      pwm: pca9685: Drop unused assignment of acpi_device_id driver data
      pwm: Use named initializers for arrays of acpi_device_id
      pwm: Unify coding style of acpi_device_id arrays
      pwm: Unify coding style of of_device_id arrays
      pwm: lpss-pci: Unify coding style of pci_device_id array

Yi-Wei Wang (1):
      pwm: tegra: Avoid hard-coded max clock frequency

 .../bindings/pwm/nvidia,tegra20-pwm.yaml           |   1 +
 drivers/pwm/Kconfig                                |   2 +-
 drivers/pwm/core.c                                 |   6 +-
 drivers/pwm/pwm-adp5585.c                          |   4 +-
 drivers/pwm/pwm-apple.c                            |   2 +-
 drivers/pwm/pwm-argon-fan-hat.c                    |   2 +-
 drivers/pwm/pwm-atmel-hlcdc.c                      |  15 +-
 drivers/pwm/pwm-atmel-tcb.c                        |   6 +-
 drivers/pwm/pwm-atmel.c                            |   3 +-
 drivers/pwm/pwm-bcm-iproc.c                        |   2 +-
 drivers/pwm/pwm-bcm-kona.c                         |   2 +-
 drivers/pwm/pwm-bcm2835.c                          |   2 +-
 drivers/pwm/pwm-berlin.c                           |   2 +-
 drivers/pwm/pwm-brcmstb.c                          |   2 +-
 drivers/pwm/pwm-clk.c                              |   2 +-
 drivers/pwm/pwm-clps711x.c                         |   2 +-
 drivers/pwm/pwm-cros-ec.c                          |   2 +-
 drivers/pwm/pwm-hibvt.c                            |   2 +-
 drivers/pwm/pwm-imx-tpm.c                          |   2 +-
 drivers/pwm/pwm-imx1.c                             |   2 +-
 drivers/pwm/pwm-imx27.c                            |   2 +-
 drivers/pwm/pwm-ipq.c                              |   4 +-
 drivers/pwm/pwm-jz4740.c                           |   2 +-
 drivers/pwm/pwm-loongson.c                         |   2 +-
 drivers/pwm/pwm-lp3943.c                           |   2 +-
 drivers/pwm/pwm-lpc18xx-sct.c                      |   2 +-
 drivers/pwm/pwm-lpc32xx.c                          |   2 +-
 drivers/pwm/pwm-lpss-pci.c                         |   2 +-
 drivers/pwm/pwm-lpss-platform.c                    |  10 +-
 drivers/pwm/pwm-mc33xs2410.c                       |   2 +-
 drivers/pwm/pwm-mediatek.c                         |   2 +-
 drivers/pwm/pwm-meson.c                            |   9 +-
 drivers/pwm/pwm-mtk-disp.c                         |   8 +-
 drivers/pwm/pwm-mxs.c                              |   2 +-
 drivers/pwm/pwm-omap-dmtimer.c                     |   4 +-
 drivers/pwm/pwm-pca9685.c                          |   6 +-
 drivers/pwm/pwm-pxa.c                              |  30 ++--
 drivers/pwm/pwm-raspberrypi-poe.c                  |   2 +-
 drivers/pwm/pwm-rcar.c                             |   4 +-
 drivers/pwm/pwm-renesas-tpu.c                      |  10 +-
 drivers/pwm/pwm-rockchip.c                         |   8 +-
 drivers/pwm/pwm-rzg2l-gpt.c                        |   7 +-
 drivers/pwm/pwm-samsung.c                          |   2 +-
 drivers/pwm/pwm-sifive.c                           |   2 +-
 drivers/pwm/pwm-sl28cpld.c                         |   2 +-
 drivers/pwm/pwm-sophgo-sg2042.c                    |   7 +-
 drivers/pwm/pwm-sprd.c                             |   4 +-
 drivers/pwm/pwm-sti.c                              |   2 +-
 drivers/pwm/pwm-stm32-lp.c                         |   4 +-
 drivers/pwm/pwm-stm32.c                            |   6 +-
 drivers/pwm/pwm-sun4i.c                            |   2 +-
 drivers/pwm/pwm-sunplus.c                          |   4 +-
 drivers/pwm/pwm-tegra.c                            | 160 ++++++++++++++---=
----
 drivers/pwm/pwm-tiecap.c                           |   6 +-
 drivers/pwm/pwm-tiehrpwm.c                         |   2 +-
 drivers/pwm/pwm-twl-led.c                          |   2 +-
 drivers/pwm/pwm-twl.c                              |   2 +-
 drivers/pwm/pwm-visconti.c                         |   2 +-
 drivers/pwm/pwm-vt8500.c                           |   2 +-
 drivers/pwm/pwm-xilinx.c                           |   4 +-
 drivers/pwm/pwm_th1520.rs                          |  12 +-
 rust/kernel/pwm.rs                                 |   4 +-
 62 files changed, 232 insertions(+), 184 deletions(-)

--pv4kxscp2kaxymhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqCOrYACgkQj4D7WH0S
/k5snwf/Yu37ckweNwhrXqB9PyTX0R0tO2kSWyzYB6evUgOfLjYCZO5jWwpNC2jz
Kw7F3rtRQB+iFYqXkEf3VUIA6ExzfVVDAV6l5rwq0kY1fC+XZUtgE76yb4yrKm5d
ZNpqqm5p21rWv5z/OchBawquKwhhFGPycW+qWUT69Xc7rIJNlPgctD42EyeTdWyA
Wel0K4UWEhTTW2klqnS7HPYCBzrL+ITCgcj+e8KIud74tGcm8A8//RMiViSD/xmZ
ltonWuM4RGRt0+EuenTidOD/73a4EibV42dex57e7BSPbok7Ic4UPB8hf9o7L28r
W+CPXpCvu6bZt64DQKO4qI35BsmfZw==
=F+0+
-----END PGP SIGNATURE-----

--pv4kxscp2kaxymhl--
