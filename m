Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3DB3C5536
	for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2026 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179161; cv=none; b=nZqhe9ensH1JX2wUORj9x2n04nEsAI5gPZjhVNQBBYVFtmn2hSn2y94BkaQarxqxN0/wM+a7EphZ7Ebcn54Uo/zVDN4McpnS2CpXXfzGaIJW5Ynwq+9dv8FSSj/GlgWhGD6Hjycx231hmMIjwfE6wJ9rF8tPV29faHFBVjx5b7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179161; c=relaxed/simple;
	bh=br2GX12R/HfpiLwzsj1/S/8DyFMuLHUl83yTUA1p69k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkDs89OG0Goco78RJ6hDmYxuV9t+ZXLhGP8lbnpUEOM/mrltPx1LJSqzVCNUmu/wnt9ifRjfsprOIhjwXQtTnjzrLa2RZs2B+ZTegExW5XM13wSMR61qL2lwwqwEF7TCS1URSoLQEzguCtrm4qyDBHoEhY8rcfMnSqZxrRGjiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aReIlCrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aReIlCrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252941F000CC
	for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2026 19:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792179157;
	bh=br2GX12R/HfpiLwzsj1/S/8DyFMuLHUl83yTUA1p69k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aReIlCrf8fopyF3ChiCIeEC1hCVb1THWDlgJCVjWvzHnaPg3t3MAIyhg8Fr1qc9/g
	 bAFQSCdM5MdEygdgrMT8ldLha9m7P76w8w6j/7Xw2O2MUqWQ6S1ORocCep7vvCWVnv
	 6hN0Z+UiwikKN26uxBoYDhnDL75AwoLrOZrzm4Wl/DB//rug2d1E8QgBEjZqYKxW3W
	 5tky7SVtLE2Zvp2ombz8vwf/m0T1ZSSfLSpKAT5HChrlAldlFv5MPjciI1qM4I3hEq
	 xfKCn0ertUbTqq5kBKCae86MJZ9OOf7Y0gtSgJIidcPulfTy0uOrszZtTvLLlEs46h
	 k+Gm5MHX5lKIg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso337134a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2026 12:32:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBybpMe/3NUsoQz0wJ7Yl6ArWxOHLgJFz+yDK01e8hAxFCklwuVXERfVyrtZ9u50EpOdR1gCJMvfFgE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHqaDgh973h4cQxTB9hijCM/m0Jlk2v2TBR0W1cWND4kpamxGu
	VGxZk1FxT0xZT1EJxyt2fR5p3XxkoeZZlw3dvRMvbT0mHbgxvIG8p/j3n6kfTFbWd1cFy9L3txv
	iiplctUUfTQzrXHOA5bbA/+0/ycFZyQ==
X-Received: by 2002:a17:907:3f95:b0:c34:c5e8:1dc5 with SMTP id
 a640c23a62f3a-c419da41344mr62932166b.20.1792179155493; Fri, 16 Oct 2026
 12:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790606188.git.andrea.porta@suse.com> <ad9bc35d7c30f7925fed4c6621ed0f67c39c3f09.1790606188.git.andrea.porta@suse.com>
 <7c437a10-985b-402c-b3ac-cfa97c53d014@broadcom.com>
In-Reply-To: <7c437a10-985b-402c-b3ac-cfa97c53d014@broadcom.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Oct 2026 14:32:24 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+rjfk-EGKy+sf-S7QRpGy_7SC38ZUASs28gWm_PuNDvQ@mail.gmail.com>
X-Gm-Features: AclHuK-3lCKkhjPmvIybYNhFqPMhoSBVuchxzZzjM1TnQd3DNXu0J5TqQN1c3O4
Message-ID: <CAL_Jsq+rjfk-EGKy+sf-S7QRpGy_7SC38ZUASs28gWm_PuNDvQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] arm64: dts: broadcom: rpi-5: Add RP1 PWM node
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-pwm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Naushir Patuck <naush@raspberrypi.com>, 
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com, Sean Young <sean@mess.org>, 
	Julian Braha <julianbraha@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:26=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 9/28/26 07:42, Andrea della Porta wrote:
> > From: Stanimir Varbanov <svarbanov@suse.de>
> >
> > The RP1 chipset used on the Raspberry Pi 5 features an integrated
> > PWM controller to drive the cooling fan.
> >
> > Add the corresponding DT node for this PWM controller.
> >
> > Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> > Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
>
> Applied to devicetre-arm64/next, thanks!

And that introduces warnings because the PWM binding is not applied.
Either wait for the binding to be applied or apply the binding with
the .dts change. IOW, Broadcom is warning free (you're welcome), don't
introduce warnings.

Rob
