Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8604D7D56;
	Wed, 16 Sep 2026 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580700; cv=none; b=otCrA9+m3rcZtJNMfU9n/OYp3JixlwEzSvKr/uJB2YAA5fiIxWV9oljJp4h751KtwwZJu278xLbt8cC1o2qsM5JmGolX3V9wq3K1/Css61xrVI2U2RDPj6Gz4X2BubJ+ncUOmbDj/h6k0TBHEQxs9iyQ8R30EZ69iWHeGlGeWdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580700; c=relaxed/simple;
	bh=vVgvE+DVRi10/wjC5BXvLaAYZOW2gQVgtP/dxaimUs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiFxOJjtf7Ke2Io2yUvHDYZ+jVU8IORzYuHOTugzcXQg6IanxZDv/M2gyPLCszZRpEi3x3UA2nvG+I6tVJ6PBWIR/BINyQhmvDPtZGS+anQFl6a7nTpSLZrXrAAkc//K7Z0IGDXI69DurfJrD2V8dyH1hblsfxeWC9JGFzdd5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j3DRG/GW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j3DRG/GW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B2B574E40762;
	Wed, 16 Sep 2026 17:44:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7A56260337;
	Wed, 16 Sep 2026 17:44:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78E4211C7B00D;
	Wed, 16 Sep 2026 19:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789580687; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zOkNP+060kWI8evPyG7XxKhlF+a9qe7vg/5I3PYHEvM=;
	b=j3DRG/GWTMPDRpKHz/mq4qYTx10eN3k3TsNMPo4cT4NpLZTlXFXVAybtKtKSos+oBtKLTB
	TN+7dhPC2raqihaHzMiLCbXDOhjVPOz3zqZeY9aoXRbCtxUsddUJCE83mtWI+++1yACvSz
	xxwFwwws7DPyU/y7+Y4LYgQpZqdSvCRMLoM6EpV3kq3H4hEwoimu4f3xvskmtcuCQWR2en
	s1t8ANmndtdUsiLn7rNJndVnZDAmHzYZCxsUq9hQzV/5CsGYTx8DOqCtT8cgSpm2jFh+BS
	W65k+7mSfdjPn1uTtCI2togN8I4dgqgrRhrym9QDOsF65yZXnEI+LambFUEgHQ==
Date: Wed, 16 Sep 2026 19:44:44 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li
 <Frank.li@oss.nxp.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH v2 2/7] of: property: fw_devlink: Report unsupported
 supplier linking
Message-ID: <20260916194444.7d677516@bootlin.com>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-2-17ac82dbe226@toradex.com>
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
	<20260910-fw-devlink-nexus-ready-v2-2-17ac82dbe226@toradex.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Ernest,

On Thu, 10 Sep 2026 16:16:43 +0200
Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:

> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> OF supplier linking is deliberately disabled on OLPC and Intel CE4100
> systems. The add_links operation currently returns zero on these systems,
> so callers cannot distinguish unsupported linking from success.
> 
> Return -EOPNOTSUPP when supplier linking is unsupported. This allows OF
> unit tests to skip link assertions on these systems without exposing the
> private platform-support predicate.
> 
> The driver core ignores the add_links return value and marks the fwnode
> as processed regardless, so its link creation and retry behavior remain
> unchanged.
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
