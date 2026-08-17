Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB7540DB5B
	for <linux-pwm@vger.kernel.org>; Mon, 17 Aug 2026 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968629; cv=none; b=lKMVrMeWoGpozJevOTCKPn/XdTzaYwxl/CL5XDEyjsHjwfnP9OsXy24hIjzaB6KrcPqiMyDOhIEuaghtzaxBhlOJQBt0rdGcIXn7ASMo/CGYyWo0+Pob8uOrWLLcM17yKVGdxebvhVJhWO8o7NBXbxxVo1zGJG9HSxtOqHv8bbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968629; c=relaxed/simple;
	bh=jMP9MThjemeYakXj/pzFSuQjW7TmSmOZN8BM7kKu6WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/mdD/olFtg35D8f7rwpVEnZ6nu/8tnUWQ0bAON8IVaDb14cxQlL1VorDUYcvNw6BgnjneFEij1q32XdTOiztnc3SrYaFYyBEiBWJ5ETwKZ36kmtVlfzraUXd6WHJFPemYHd50XJtoo8aCPdhngzNyFEf8w5fP1T2TJn9AQMaGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar60WZMQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar60WZMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C838D1F00ACA
	for <linux-pwm@vger.kernel.org>; Mon, 17 Aug 2026 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968627;
	bh=jMP9MThjemeYakXj/pzFSuQjW7TmSmOZN8BM7kKu6WA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ar60WZMQlC7gs2F5ZHqfaH6KnDT4lwvUI2jeEPrBLgkChoVAZbEqaxn5drdhkNigw
	 3qHPnbFraM5wx1YmWJ5HrZLi6Synh/HSU4sBzNVsv6DmvXYBNYcHwdZV7XrWr94XCM
	 L8iYrGWsQi15lPlxFFQYWSmeuC9T+Aza9BMf0dVhNTjpVWKL+9b6nITSRLCxqIfkV9
	 o/3/NFtleliIs8QShTGQp5K0D2kyL2ASGpHDjacSrN5F391NKZY7SNZ8d+y26coSI2
	 SCMR5oSBmEUhhbko0Hmreb5FH90vL6jCUlJ0LcR6frNU8fEqEeQYNBizobogRUEl2p
	 kkhLzWqG667Zw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b29599b81cso4584484e87.1
        for <linux-pwm@vger.kernel.org>; Mon, 17 Aug 2026 05:10:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoMhDz597Zsq7Iq+LzmApJv/hHQIR+e5zhpbj9AJKfPx2Ykvcy5nh2PyWCGrLNuikc1vOE6fkw3OBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZCreHmduZqnnaG1iEIpH81Oy8t8MJFzuYYDxIp+61KnY5XA4
	tSoC2q9M3xploVWwEN2Ou/T3iUUIwQSvnXCZRFxKS13mkPPFKCQA61zZpsWIAp+c/j1f2Rz7Gi5
	v6R1PELNWhLr0yFBnBZZ6lWkZ6/R7P4s=
X-Received: by 2002:a05:6512:a34d:b0:5b4:475f:c322 with SMTP id
 2adb3069b0e04-5b45913fe58mr2462718e87.43.1786968626410; Mon, 17 Aug 2026
 05:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816060648.4030-1-farbere@amazon.com> <20260816060648.4030-2-farbere@amazon.com>
 <aoFgF2E4p4DqYLGG@monoceros>
In-Reply-To: <aoFgF2E4p4DqYLGG@monoceros>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:10:13 +0200
X-Gmail-Original-Message-ID: <CAD++jLk+MMH=-ifdSs=Vm4G9RO5-yVs8NLUb4AE1wYH5FQrmjg@mail.gmail.com>
X-Gm-Features: AcwNN1U-dnnBMYmPJIsmbHOzFmj95rCcwG-Rxxba2eA8HCClSSdawz-FswV3dYE
Message-ID: <CAD++jLk+MMH=-ifdSs=Vm4G9RO5-yVs8NLUb4AE1wYH5FQrmjg@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] notifier: add device-managed registration APIs
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Eliav Farber <farbere@amazon.com>, rafael@kernel.org, tony.luck@intel.com, 
	bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org, 
	xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, fabio.m.de.francesco@linux.intel.com, kaihengf@nvidia.com, 
	ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, paulmck@kernel.org, 
	frederic@kernel.org, kees@kernel.org, saket.dumbre@intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 9:04=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:

> I suggested to add "Must be called in process context." to the kdoc for
> devm_atomic_notifier_chain_register() as this is a relevant difference
> to atomic_notifier_chain_register() and create an immutable branch for
> it as a base for subsystems to apply their follow-up patches. I'd wait
> till Wednesday for concerns and review tags to tickle in.

I think this is a good approach, but we are in the merge window,
don't you wanna wait for v7.3-rc1 and create the immutable branch
based on that?

(But Bartosz will be the one pulling the immutable branch...)

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
