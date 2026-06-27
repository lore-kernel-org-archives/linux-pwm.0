Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95FA3A6F1C
	for <linux-pwm@vger.kernel.org>; Sat, 27 Jun 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782570124; cv=pass; b=T/YoeRqBmrXOnmMwJY/IE5yqUN0OTZ2pb49xYmA7xK/4HUn5SS/SMGN9vRzdMK4Qi7qRnpNyO5ZShZwG3YQy2Nb7bHJIKQkSy+Tz6XWuzcmyl/k8nR9fYZ2LhzPMDQM+tRIJi9tOj2bweQzHb9tgl1Qihizc7u7fA1aapvSoOOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782570124; c=relaxed/simple;
	bh=hgYR+me/WqBHOq1AxI3Al6Lomfd9P4rKWlIodfqB2Mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AT871sqiobmg2RnPu2OcZfAhSkgMBYHKXYqeMQnR/Gdf/e7fdoMnFri3JgXemg6/XbVW+JNOjNSy3YbVbKRa6Djlb3qYoR5GiUxRM4RUb7JzWyKdsueNHx0L33kK1EsfgOdXBane0WioiaSyJ7sAyzdhhEYzlL1g/I5z51v4gLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVEjWYzF; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVEjWYzF"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c53dc859cso151339eec.0
        for <linux-pwm@vger.kernel.org>; Sat, 27 Jun 2026 07:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782570123; cv=none;
        d=google.com; s=arc-20260327;
        b=UpabH99o4vI5KJaeKqKz2b+G/986AKMT6qYFL47xnHg8WXTijqwaMnXG1VBlDC0h+7
         rzoNeLaztpS+Cyl7GKImEKEZoM4xtw9aOJmNpVWhlFoa6lp3wjzW5NQpSP8CaGi47GOs
         CUq0vsaJHsIgst5dOP7Cp/uO05EjXiAamXGeGDwPc5B/02gVrfmagk9RbDo7wfR409+h
         YMxbkvCaYRwhsp4wAVRGAYtPf4SXU7P4tuAIMuipkE6x3kpATQaJyFtZS7S19W939Tph
         +3Niov0VtmlYOVglp+36/exVZVCGe7MiSy4DAEUj7327LNcdxOIGxFXRsx4xVvA0OuQX
         Uifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dnhPY84nbVl3Rm52MamXsK8B6ygO2wlFwCT+T0hkkOs=;
        fh=8pJ44Ne3nOUo0/QIOmpab1UBeUAjlI8xOWdKHZOHKGw=;
        b=Y7zGxOWY9OBzogJN1K7jtNpWXNSEODwxYb//JSSwNoJtlgChwW5WOV4APnXxkltyMi
         r6QkTxbg1Q/1eyli9EqpC1O6rD+iWkz+GkemcouR45OjhMKNEUEn1kDObW/PcokFLFk2
         c5xt3K3PaNG+PBFFAyyk8pX6+6tho0BC4mj6m5xiqDS/UBTo6oJ+Tzo6+MX5p4+z94SG
         fhgZo9biPOvbNUgDBZ7idpOmI5jwJe+QDiJ86A5QtgCu43Q+6PUKbWk18W0TRF+ovs5a
         OjL87LsPf/scMTu2TAJ0Sf5/9LSw/lJPYXhQms1PoDdABwP+MH8UnNzD6SP4KFv6E9sm
         CyVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782570123; x=1783174923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dnhPY84nbVl3Rm52MamXsK8B6ygO2wlFwCT+T0hkkOs=;
        b=NVEjWYzF05WyTbdn7SOYkAmR78SpwH7+R+TdGAuVjpEyg704FiMNqdShrbR1EZRnoZ
         NAPIrljL5qwLtZRgtclsQE8RKA3pwuBBKkcSorKUN+cJMhCYVT2dGcoJ1BRM4Sk83ImQ
         5ZyvSMhpI56MJUHLZKa6qmedVA8oDPSlEgG2oCwruw/d33jPz6SEeGBBXPhVRnv4+sKz
         urOfFX8gH5L65LeCPiyCQ/kq+i6rrbyhbsGhpQQyzUEUkEClxRwiy6XMe30c+TnnjZgo
         DF0aJYTrndnVQFA21B6bx3lcYtdZ58SVPQdXsSlW5s1Y9e4sNEbpHw64I41HTJRKMmZL
         Cwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782570123; x=1783174923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dnhPY84nbVl3Rm52MamXsK8B6ygO2wlFwCT+T0hkkOs=;
        b=W2l1zrBCv2wvyp0n+L6Z/VMxP4gFzfaXrogppWl4x3Wzj7u+XywN0VMuEr4UhmPXbs
         k/6VZI4fU2XUae+cSxYesaU6yLwl0vO4Pgl0YtmPlk1BIyMAcMNYT8au9ftVtNRCO9qp
         8rf/QSxcoIU5jsyIOk7Sul6wSodfs9giVKCxBoTAszp//KwKyt8+7YZEecP0jaR6OxRy
         rzKWlS3WdfGFRREPPD8V9VeHUrqh2J2cWclHMu6QmVfY4j105ABF8+gXmZmTTnw9sjZK
         NzjToB33cwR/WR38CoPNl+NKIEKg/9ZuDeZsHhMg0uKKwCX/gPU79fWU32hDSlzn9YHd
         tpzg==
X-Forwarded-Encrypted: i=1; AHgh+RqG6jx3ivS4ZzsKt+xNI3ancKXDNLtFDfUk6VYObRsn8eRTMMGVHR4w9l39wthDkiM/lAVv8kTOfec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNedzRM8vxgR6+zu7ufdJSvkEm72+c5StSEQYcPNdBU52sLTqp
	nHiAKuuDpnmOWVtnENXtjEnPGd0GxRcHDIgjONI69sDxsEUtfB9tS00D9+e+6soV+fWeK/JHsc1
	C5bxRKxcWn6ZDg/N4MQIW3xqiX10D1h4=
X-Gm-Gg: AfdE7cmQCd2kB/Qek5lVLOWhlVbXwyNDBrmYabI/DLXG/C0UJzmri+You++iAF2ZmXa
	lLiCPux7itxJ+TAjpdp6+r8TpZ0hIeXiEwUOaw3AdxBD0gQxHWVAyxspGv5P2SSG+pli8SsTfxh
	Jo19xL+Exvm0RAh+nHOVgLlMsqCknV7dbw24YNFitjaO9sd28PJ2qKXXr27A97WI8lW+Z9ia4lA
	PoTX3bEkXZW7FSX+tRvcAkjRJR2tLtXCixKFrHjlEtl5jNCDdqZNc1k+XdHrs0V3yRLJV/jij4u
	M9JGy8oJLYNkLV3NJbbetKe7OJ8x5AbCAzpmnCKg1/W6ihKpJKyCQcKhWwplhQdY9wZuzxZpEpG
	Fy29Rvrce5JdC
X-Received: by 2002:a05:7300:ec01:b0:30b:e157:2641 with SMTP id
 5a478bee46e88-30c84d6411amr4636635eec.6.1782570122681; Sat, 27 Jun 2026
 07:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626183630.2585057-1-dakr@kernel.org> <20260626183630.2585057-3-dakr@kernel.org>
 <CANiq72=0OOgc6NtbpF0Ysdk3ytRWCGGbWg00u0Le2AzQmKGKxg@mail.gmail.com> <DJJVPW8H183T.1927SIBS40Z40@kernel.org>
In-Reply-To: <DJJVPW8H183T.1927SIBS40Z40@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 27 Jun 2026 16:21:50 +0200
X-Gm-Features: AVVi8CctSDh_S_EW23arFCE2Q437EiWrwvRaI2YwlTvVdF9BNVV6NJ35O27uGtM
Message-ID: <CANiq72nr6UD=W6oFsJQaGrSFCRqyWnY80=SyNR7u6=eVQ7ci=Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] rust: types: introduce ForLt base trait for CovariantForLt
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, acourbot@nvidia.com, ecourtney@nvidia.com, 
	m.wilczynski@samsung.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, daniel.almeida@collabora.com, bhelgaas@google.com, 
	kwilczynski@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 3:51=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> The only way this could silently break would be to use ForLt!(), but then=
 don't
> use the explicitly provided safe cast_ref() method, and instead open-code=
 it
> with an unsafe transmute() assuming covariance from ForLt!().

Yeah, that is the not-compile-error case I was considering.

i.e. I was trying to think if there could be an issue with the name
reuse, since it can always be a pitfall. For in-tree I agree it isn't
a problem. For out-of-tree users, given it is very new and it is
unlikely they had that case, I think it is also fine.

(But e.g. if it were something that had been there for a long time,
e.g. in an LTS already, then I would say it would have been better to
pick another name).

> I can add them on apply, or we leave them as good first issue, as you pre=
fer.

Up to you! I didn't want to add noise/nit work, but if it is fixed
already, then that is great.

[ I also saw some non-Markdown comments in the other commits, e.g.

    // Invariant ForLt types (e.g. containing a Mutex)

  in the sample. ]

Thanks!

Cheers,
Miguel
