Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8944F545
	for <linux-pwm@vger.kernel.org>; Fri, 11 Sep 2026 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113123; cv=none; b=IbRmUBy+ZiW+0HO6Ur5xesJfpH9pX7URY3BLjS6uAfVXrApdXDyiqwtA2L+ErOBY0sOP7BGcQ6tx0rZmB/tyToOZb8rcIos2Ads/DIoBmQ2IaDZSFc+BWxZ7053SUT5iWfJ5iQN8PJ4vJVqJ0OZdMVoqFw8R7//w3kzN6zXwIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113123; c=relaxed/simple;
	bh=sIfYuQRbITcqYg8S5QoIxQuTw8bHmv1mR3yE9m3s/Q0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdFtJ5Si73a/YDomXxcAxi5IUEbZ05h7kp0TiCjqyKtv9IiPxVTXbwlx69rDAMqvacRLzK8KiRLmUqvoRPavRvz+zQJeOZ+FbcrqvHGFCNK7lVaUlLb+5lf8jNvd484xrSE3NMkvMd2jLFIDKIB1sVCDherseYRIu0hnJ4CHcG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMebYxok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMebYxok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489961F008A6
	for <linux-pwm@vger.kernel.org>; Fri, 11 Sep 2026 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789113122;
	bh=sIfYuQRbITcqYg8S5QoIxQuTw8bHmv1mR3yE9m3s/Q0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=bMebYxokBAsoK8ym0hzKk+fuy2XXGpsABgpUBSgx7kG7V7bZaYjTBDPoQfVQz/hsa
	 cKM153D71qTG1/Yethzqr48Bo/+j+EydAib3kH3OADtm6Wgnoe4Rm8Gwi3wMU0AxJ5
	 D86Zke0iUUj+udvcc0/RmQFWPE4b8VcV5A75pB74Vy9vfghcQRoArUDzGU2XuJ3ibL
	 Hqa6j7DYij7QKGCkGFWv8y3nSP1qLWCI9DfBWJWhbqlYqEwgUZZtioQnt8G9E1Vq83
	 KiBJHD7yyAQJq3GU1BBysCaxGrMB9rxiWKiUuYJc+MWFOIJejD9cnCU4amh39yDH6B
	 3+AoI+Gqj58kA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b81a2d33f7so693876e87.3
        for <linux-pwm@vger.kernel.org>; Fri, 11 Sep 2026 00:52:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzvlMZ0k7IDYplejtX9x2RQi2Q45SH+wRpK2znWWdkup09kYQKLILb4jAjo+EfmiU3hF33JxEV30yw=@vger.kernel.org
X-Gm-Message-State: AFuF++kLGwEhHl5ZcI/1Pv1fxcjkTrt3XDtT0SbSjpFCghyh2XWReU3q
	lpT7CTLtORUEWvGQMFgc/ssfs19gywYXxAnO7myGhMMiRMFaspmsD1r/oQif7krK/lqEF0GExRX
	RwpTSnUMPCnH6NbKGbMPsopxGl3m4wq9WQk452shvBw==
X-Received: by 2002:a05:6512:b83:b0:5b6:1a7c:59db with SMTP id
 2adb3069b0e04-5b8a0310b1fmr656473e87.53.1789113120636; Fri, 11 Sep 2026
 00:52:00 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:51:58 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:51:58 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-3-17ac82dbe226@toradex.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com> <20260910-fw-devlink-nexus-ready-v2-3-17ac82dbe226@toradex.com>
Date: Fri, 11 Sep 2026 00:51:58 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeSJ17QNZv2a+SGLmkArfkDfJ+LA63RzkyR+NwEYQ9gew@mail.gmail.com>
X-Gm-Features: AcwNN1UyqJBiFNt7-qUOGGcLehzd1eL0p4Al7jFGd5C7-EaGiR5r0kJ7dxhhmpE
Message-ID: <CAMRc=MeSJ17QNZv2a+SGLmkArfkDfJ+LA63RzkyR+NwEYQ9gew@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] of: unittest: Test fw_devlink with GPIO nexus maps
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Sep 2026 16:16:44 +0200, Ernest Van Hoecke
<ernestvanhoecke@gmail.com> said:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> Add OF unit tests that call the fw_devlink add_links operation for GPIOs
> routed through nexus maps. Verify that each mapped consumer has exactly
> one link to the final GPIO provider rather than to the nexus.
>
> Also cover direct references and all GPIO property spellings recognized
> by fw_devlink, including the deprecated singular and unprefixed forms.
>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
