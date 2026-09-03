Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94046DFF6
	for <linux-pwm@vger.kernel.org>; Thu,  3 Sep 2026 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436279; cv=none; b=WzoU83WKZuzx0v2j4FGXThGukWdMOOjMs4icb7VFjFp5NGNP+V3nEn73+zbh17gw1kTjoLjDsDMjVBaw/yCQ/lHPWwUlZT99hHFr8H7LiLuVJs+lK3cxBcApTxPgq/70LmdesTP2zGJv0ze9Swql3siFNS+6kxxBArKcXDAFH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436279; c=relaxed/simple;
	bh=C+QWB+KZzeonLvV0qDuesLnMy5eu8R+OizXBY3d888s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTW1HIC1fIO+XIwKjjWG9BaOh9qMQlKI9v33COP3Jv+FXOWpsPKyVZdmMitX/w+rYK6Sbd3Kq9TumRdthnEhqPy9KB2zefw0nmYq8Mn6tOpoP00WYJdguHvIULf3S82hdVk4KHyB17JD9+UlpGpOGWrQ0JIfLpQKf0P6plEaxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuMsJK6I; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuMsJK6I"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-485853f8800so142722f8f.0
        for <linux-pwm@vger.kernel.org>; Thu, 03 Sep 2026 04:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788436272; x=1789041072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1LiMV9lpRiXnBE6CK4fygOV5eeeeR5AdD/GCs6lVbQQ=;
        b=QuMsJK6IPyQoldLxUmoNS8vlhkN23066FUD8gMtVLSfPwrcA0V8B+oGC+OsBPzuOHr
         YIPb4F0p4CrJSOvCV0YUbQ086PADTWdAsxcinxy4Pm10a6gzblDtcOeMqTe3L5WrYzq2
         LkKA9YNCMkx7Y/W+6pj1HEx5JBSBB6GXoFdOeoccfNTtyxmSsRAXKxVBIcHRkJa6LHdk
         3J8xI6RTRiGT0rTNrLg3l6TpB6GFKWStuO8RCY/CNSvSXcpfmJw2PVfCwX0dxrOGuxoq
         MPUrkweb4VYWWqu+89gf9nHf0oucmQmNnwVC34o9XTdW+iU7kqW+PIn6ob3tfV3mpFDs
         qFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436272; x=1789041072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1LiMV9lpRiXnBE6CK4fygOV5eeeeR5AdD/GCs6lVbQQ=;
        b=QMBW8vr54cGYgR9TvGCsvLwiEZJ6cighNXQnLwgkUu6bE8z4/yEd7HF0lMlDcVFt/2
         hlDjdg6GvisW0Cvyk5/Tkzw+Vy4GoTDnor5XXXCVWA+zdUpz/NhSANihK8Nh7vpMZCR/
         35pCnhagUzF9blZcnhtr7ufIzv9zGZtHayb+eQx4JuVzEZpxPczMMVPHZcXCMApX4X3p
         OOgg1XeHmq+zl8qgBi7PpXr1dR99VEC25J6xml9dj61nQP+N1thbcDcVz+WeoemBaQJc
         sWu00+PhU8DygLqfQFoV0W9AsyslriZbNDMyhuGISZrt1ojthYQ/UlRFb3VluQtbjBkT
         eDmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOy4N9lAU0DiNcf2WEqUFHSJ9G8gG6wMmcWTItn80R6EG1yd6JPDtwjZMs6kEE/fghQIS3umjEUPg=@vger.kernel.org
X-Gm-Message-State: AFuF++n8Zyf3yWSifAOHZ3BwHcF2cUCxKKSTsRHlIodLmWqpMeHcAzbw
	k3uhkLytkpulyuY6gYI6LKf9tILrXBS5Xz090OraVZ4j4dM4tkYEwUPD
X-Gm-Gg: AYBFou0zhFx4ut97YE5wVPf3RuFeQlTG6FoUy/fX8C9nbZId9ByvAyLjIaUJj//WF72
	IL74XpoScSoTtF0U2Q5mg5DJ4ZOkeN8JQiEH/PzWoE4D28j74Pa7oRQeMILmr7YkuuyKd984Wcm
	V629WPAhtsfbBpTwgX2ULvb5etXH4xLBDxeY+mW5CdRdMEVW+mwqHyQHam0+q8snCsYrFrh4+DW
	EbL4bBGkpXUdf8e3pyTjZhvoydSS0uV1K6L1lHvh55ePm6Y5K+N4+bpU/ZoYR0PkzaSKiSVFciU
	Qct6G+8wDq2hNQNZFjXhwmkGkqSkeAh8X4F1gs/1PwBOlrpH9MRnqyj0Yz5T1tiuciLso8qd2An
	4OQmGzPEhLyiWar07npihmZw+cw6aabegsUJRv9LUa79CK8QqeUS81tQzJBeW7KBXTSeHbzRI/4
	A830Q8NsX2K1pi3x0oIHst+RZpYijpCFL+hneDMHF2Mq46UMNy6wsh1sG6oYaD+bkUGFHLtAvLg
	vEQiSh1x/KD0BBa4fMJH0W89OZxNDDnMcs+ylhzSOBC5eoiSh1hDZKrVH5gN8nsbJZYX71SyA==
X-Received: by 2002:a05:6000:542:b0:484:361a:1c7b with SMTP id ffacd0b85a97d-4857e4eb54dmr6750369f8f.7.1788436272260;
        Thu, 03 Sep 2026 04:51:12 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e6f604sm13185506f8f.2.2026.09.03.04.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:51:11 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:51:10 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Herve Codina <herve.codina@bootlin.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Linus Walleij <linusw@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] of: property: fw_devlink: Follow GPIO nexus maps
Message-ID: <hxtrtbmfb3jznfw7ooiyx533fzuuagxlhweq6yo4n6j5bne2uh@omibim7aiobk>
References: <20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com>
 <20260902-fw-devlink-nexus-ready-v1-1-68fe1996e78a@toradex.com>
 <CAMRc=MfN73=K1nZrqUbhrMSijjpzhF_z_U9JU4_H163W0vRpqA@mail.gmail.com>
 <qg2nemg4mlxpancg7az2vsnjkfc4anxkieozoxh3mj3zgkyifd@b5b6yiz4uew3>
 <20260902185513.4867bc92@bootlin.com>
 <874ig664ih.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ig664ih.fsf@bootlin.com>

On Thu, Sep 03, 2026 at 11:57:58AM +0200, Miquel Raynal wrote:
> Hello Ernest,
> 
> On 02/09/2026 at 18:55:13 +02, Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > Hi Ernest, Bartosz,
> >
> > On Wed, 2 Sep 2026 15:22:36 +0200
> > Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:
> >
> >> On Wed, Sep 02, 2026 at 05:30:19AM -0700, Bartosz Golaszewski wrote:
> >> > On Wed, 2 Sep 2026 13:41:39 +0200, Ernest Van Hoecke
> >> > <ernestvanhoecke@gmail.com> said:  
> >> > > From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> >> > >
> >> > > GPIO consumers use of_parse_phandle_with_args_map() to resolve specifiers
> >> > > through gpio-map properties. fw_devlink instead parses GPIO properties as  
> >> > 
> >> > Unlike PWM, there's no such thing as "gpio-map" properties.
> 
> Just as an FYI, there is a pending series to extend the nexus
> node concept to clocks, this may also require some fw-devlink magic :-)
> 
> Link: https://lore.kernel.org/linux-clk/20260807-schneider-v7-2-rc1-eip201-upstream-v5-0-8785f9531cf0@bootlin.com/T/#m16ddef087544db31b5f434fa44be70aad0b5e37e
> 
> Thanks,
> Miquèl

Hi Miquèl,

That's the reason I put you in cc and also the reason I went for new
NEXUS macros in this series. Clock would hopefully be the next consumer
of that :)

I should've mentioned that more explicitly in my cover letter. Your work
on the clock nexus can certainly come in handy for us, thanks for your
input.

Kind regards,
Ernest
