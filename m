Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522253B7B9D;
	Mon, 10 Aug 2026 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359802; cv=none; b=uxnk0SxeA0bqbs1s3tfWlBRp2UEeb+59txdf+bJFr/wr6IcWfs669zR3RGK6RvQ0sSRC5qIKs0w5shJCIqV7y2Enr3wyagwE9Wm1UIxTxqIWANHVqbcnOwI+Mru6ZASX01ntsZqA6SFtYq5W/r3yseH2D3Err2V1Io3QcIEO6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359802; c=relaxed/simple;
	bh=tPKDWPlM7qCKF0aWB+iy2ky2un3tJGx4prK3cvfZ2h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwacsHrikIFOeuyxcMg506hkqC8FZtLNKQLTY7QEA1ka2Ws0+vejfJire59ccEOZWk4ifWwBAtGASyvaJ7exFeMhLMxpU5dWFHDcSwxCiVZNCFFMljLUbRxOBGaWbGUmSS58zAYDQD1fUzIL/gmka7frOH00itEse0THEa/Av/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3a3xwJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3a3xwJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0BB1F000E9;
	Mon, 10 Aug 2026 11:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359801;
	bh=6iMQbN1gCNgy7+JMf6e7+veTxTZtHFiMFfAKHtqHMKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3a3xwJUcehIhOd2byvAYDOfozBvVdLdp2TRRvQ0uHzlKukG6ESc6aEA9N3QQKEsA
	 gc4GNbqozA2ZSs793la6M6rkS6idc78RRMLF7fSG8MTzlODze73UemHu76RkAqMtEH
	 Gx0yrpliWLp6YhYPBMZAvUs/rngHur4g6khwZCjXDRTUBk71q2ivCqyFFB657W/RNo
	 b3CYjtog2dbEp31Jmz4zeUjzbvkuyyrU0Gl2kyt1WpVHSk02XDSO9J2WbO6/PWr2kq
	 o0Y8cNrQtF2/npfDPmUnm3nVocN3+6N8ohO88bNTxoXd2cF4vdE0FBXnvCqzMPXbqW
	 4KeS/AMvOdiFA==
Date: Mon, 10 Aug 2026 12:03:16 +0100
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Charan Pedumuru <charan.pedumuru@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: pwm: st,sti-pwm: convert to DT schema
Message-ID: <20260810110316.GT2869284@google.com>
References: <20260629-st-pwm-v5-1-a93f2bfec38c@gmail.com>
 <anmK4os44Uz27oR9@monoceros>
 <anmSBVnH82AE1b2Z@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anmSBVnH82AE1b2Z@monoceros>

On Mon, 10 Aug 2026, Uwe Kleine-König wrote:

> Hello,
> 
> On Mon, Aug 10, 2026 at 10:32:52AM +0200, Uwe Kleine-König wrote:
> > > Changes in v3:
> > > [...]
> > > - Change maintainer to "Lee Jones <lee.jones@linaro.org>".
> > 
> > I wonder if Lee has a comment about that. In v2 the maintainer was
> > 
> > 	Ajit Pal Singh <ajitpal.singh@st.com>
> > 
> > and I don't see Lee agree to be named maintainer. The only rationale I
> > can find was
> > 
> > 	Also the maintainer email doesn't exist now. I will change that
> > 	too with other maintainer.
> > 
> > in
> > https://lore.kernel.org/all/9379bfdb-9a9c-4fea-924c-6c1dc8e997c1@gmail.com/
> > . At some point in the past lee.jones@linaro.org didn't exist either. I
> > added that address to the list of recipents to test.
> 
> FTR: I got a Delivery Status Notification:
> 
> 	Final-Recipient: rfc822; lee.jones@linaro.org
> 	Action: failed
> 	Status: 5.1.3
> 	Diagnostic-Code: smtp; The email account that you tried to reach does not exist. Please try double-checking the recipient's email address for typos or unnecessary spaces. For more information, go to https://support.google.com/mail/?p=NoSuchUser
> 
> I marked the patch as "Changes requested" in patchwork accordingly.

Right, and I don't have much to do with this driver anymore.

If you have to put one, put the PWM maintainer(s).

-- 
Lee Jones
