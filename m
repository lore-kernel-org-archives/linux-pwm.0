Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795714756;
	b=G8dNpFj8g0L1ThiFZdlSSQCQflNqsJUoSh26QVXl04aKjfj2ilwq+8txg6mCEHGyxCpU
	 xdfU66jLdkgcmCX38tvAg83hSAmrPsYdjn5ApkU5rpACVHJURjJ47Wmo3qHT7zlMH9fQm
	 5rgWDtnjm9WCHe4OiqE1E3SyNHNDtMaYJcqIvvu/YiIdbS4ziDUKzYps5TGcOjJDUaTMm
	 DopzDMHqE84KZJDda0h5nJxQYwnWYUk2QEwfptFYayEBXv+/yVZpKYFu0i4GAGa3Wabrc
	 iDk3+Ag+Igyi4AF/COTgIgeOQnYWYRt2jrH5BCH1y/ZnQIltL2oLf812mekym4BiMpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i6Byx0vgKHEW7YL0wzB4/fobaPVqWn2TsKZAJnLVE6U=;
	b=Nx/XO2Ry+Hk5OBkl3l/lWRKzfG9XAPaQCWGrApYSr+5vr4Y4C0Af6lwRJBsq2xxOklE/
	 cF/L+IRGjAHZE6qCIoT980slw/u2j+GigXsMxTPlE7SYYtvpVo0RtovRKEW22zwXcW6iL
	 YdPnUwOqg+SFZoUap/qfll74Bn9RoIO0qzbgqEHehxHJ7HYAAu/LD695vXGrHmNgwutNJ
	 VnxE51CJ+lS/mRAKBtcAicc8BfpprTUkD6Mj8ycaia2XgU1DU009Ew77Eevqrj8/bUERG
	 cD7d1qB37m01VlhrOmZQ64WGaY1ThbSo7StJCRjhrQguxSbA7pXr/8lwcIhA1OdIxSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uci.edu;
	spf=pass smtp.mailfrom=uci.edu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE83606A31C
	for <linux-pwm@vger.kernel.org>; Thu, 26 Nov 2026 17:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE83606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-92157f2e8c1so55801576d6.1
        for <linux-pwm@vger.kernel.org>; Thu, 26 Nov 2026 09:39:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795714750; cv=none;
        d=google.com; s=arc-20260327;
        b=FHG5xJXOjv53/k80ZyQ7ohUBnrcNnm/M/zGz9cLWBAJ5U4VZ5zBQJD8G6K6dhshdUP
         sQfGb48ATB19xT2b2wG0PfFNUQMG5moOba4nCg/cB5LDzXzcgcNXR9UDR8p+IXrkeEpK
         Kk9iyy4XFS8NDvIiuMsUZAIUNFkxJzOBUGxrajLceCcmGhAB3LSt3MPTo9ShzQCto0CO
         T4qy4cn/N4G0G3aX3C4hI+LUimTAjjGEM8/EaJpGa9E6Z3YWBkeMNd6VwrTO/EfW9FT2
         vrh9fYlojEmdjmEfLsxLXvmNSbiHfD+G7dB4cv5LTrI5HGmqfWy6UnMWvgzAeCvkPSjZ
         4MGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i6Byx0vgKHEW7YL0wzB4/fobaPVqWn2TsKZAJnLVE6U=;
        fh=lhRtCZDHxxAVIkvBpn0B26dQtjQNKZP9No16GRB7epE=;
        b=mOSYfMc9XBViO1GoosYjKsKS2JErPpLVdSYc5ZQV/sfSdz6RipNyw6Yn4LO9FG73Kt
         aXGgkFeUhL65Xx7j6akA2aHhaCXHGd8qgVrBQWkT/KohtUuxLW8HJIb/PmDZ/DM88Tjv
         MCPRsLdfMkKusc9YyB8IL+PmPxBtG8kIfpATn1rvpqjeJn/Wg1p7TEnuDYH3lTDblOHD
         T/EKQ3FHwIPKX5YCWDQDDKyV8AwvEhvrER5cdm/WZK8rVUXjHpYw6emSKxN+LWAWtkM6
         8MvyncXPW/im/FMWdhKtz+EkCdtFqx5bpgrxx0Yb+sGHGcOulvFuwgVWf51ba1iQoKC3
         T77A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1795714750; x=1796319550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i6Byx0vgKHEW7YL0wzB4/fobaPVqWn2TsKZAJnLVE6U=;
        b=WAGRHCmHlEAu0arQWfqXzN06Ck0+vGe4GirOTzGET2xld0xirUELoptRM0pH8b3BUq
         CuaEwO9oxSfWw5uIf33fw5sIi7ZSZ+/Nzz3zsJt2PA9HUmXkE1DQBOFrOEuocx0ya9ZV
         W2nisvRHVsgjoYMp42NqYA4GDEVm99qMIqPlm4ssgpQYc3fWN9nom8mBm6cBTGYEdKxa
         bCs4x91XpmKDHQ5V2zxvW2vqYazIBpPVOQxrY4I2fV8YUneSXwurZ7rs5qTPxsPXf5E+
         +QmZEBop57q0QpB50Eg6ptV0qC2TjjxuKDNM5jZbEbnBM1ScCc8gFw65jA5bbHg8GnNg
         v5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795714750; x=1796319550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6Byx0vgKHEW7YL0wzB4/fobaPVqWn2TsKZAJnLVE6U=;
        b=yPTK8vYAUBCBW36dNfNmc3AUwFVaXYu6dRSJDkySsoZ4G/EHJS5b+hkHamZeFF5PCl
         BwaCPxg7AmZzHkwz1D2Y7JqkpfDXhMx4TmtWXFptTiqj0wIDXN6d6K8OvTYPTq5eGi3g
         UEgsTu/oIBdxRRXYklxuHEsaIrjhnszkykQiNNGKrF0R7mpHrYZ/NlOg8DQdbNaUjTlE
         mNTD6PZNr/ZsGHWB6/geQihFII2tkJgG8yT0ZuqDiwW4OEqYcdevxQE5gUGCuVD4jnlA
         FDRp521gY0yXbSLCF93ylAAgtLKsjCqk8Zf7qvOH1L18O30CpB+y/cMrDmKPVvCiL+UH
         HcOA==
X-Forwarded-Encrypted: i=1; AL+hErGIKXZ6Ucykv+3AKupxIzBoQ9R2vjreAkmCYRiXRIZjH0UpMYUynKdsvCneHR257MpLHijEyFC1ZFk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8T2Vf6/5icQxfDJURZ2xgqCqWU9hTAaihlYGdSjjXZ+124LICD
	srhCcSDF2ju30M5RRajF4SOJen+0uS+qnMtet3J7Em2pZGA99AGK3XNQn33oed4iSMDxO06MaTu
	cFw76NF6AUOZPNY4BTGLWLuOeX5ea+f1MR6BXXTuvpw==
X-Gm-Gg: AZFdTZewtWnXBISCqR2HirnyIpFt5XlDGHPXEIqAl4d5CVGCdLMrOFt5If3X0eHNtYI
	CVt4INzoMVSXsWSEvKFZ55hvHoGJEWMnMcF6OfM+IzyAn2ko/RPUuq+i3LCC/xmFAwvDSnGxqsq
	msOHD1kUENLfwrjG7ckTopBGDFPWyXTdhfDpllNZs4NSqOBkf98qS9FOLSu5v39qoKeIomuoE2s
	p90XP9JiyGVa1Z2mCBvJLSowOjdxT8Z6JBvD7Y9DecyI8RMD5wqF9Ck3Nvj1aiXhnwojlcElqPr
	f6Q8mFcqT/TdkGgHO70fPTwN/olJVUqYmJhhfSpoa6pv7Z6Ew86ceiAcNpIlm8obY984zC+q9L3
	VwlrxSAU07F3nvp8t3sbEWMhQc2/LVLRMAEyuii963RalO1cpN/M1aLGbSVpZ7tNPg4lw2Q==
X-Received: by 2002:a05:6214:248d:b0:920:ee20:af2f with SMTP id
 6a1803df08f44-921349db00cmr432813936d6.6.1795714749912; Thu, 26 Nov 2026
 09:39:09 -0800 (PST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794600927.git.pgovind2@uci.edu> <CGME20261113202542eucas1p27ba92593376041c476afa9c5286205cf@eucas1p2.samsung.com>
 <caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu> <9ee41556-4a24-47b2-9db3-9665048658eb@samsung.com>
In-Reply-To: <9ee41556-4a24-47b2-9db3-9665048658eb@samsung.com>
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Thu, 26 Nov 2026 09:38:59 -0800
X-Gm-Features: Aa3M54pu9Qa4ZZ6_EIlNbo-KxPT-Rg77lhi2tuQOtAvg_t6FJtZeW7oVBArQtVU
Message-ID: <CAPPBnEbnBPsYxE5ZXPkhGfueMoYD6DAH7dDrR=wRcq_mD686fg@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in `Chip::new()`
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: ojeda@kernel.org, ukleinek@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, 
	work@onurozkan.dev, elle@weathered-steel.dev, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, ardalan@uci.edu, zhiyunq@cs.ucr.edu, 
	dzueck@uci.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 7:42=E2=80=AFAM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
> The C layout uses PWMCHIP_ALIGN, which is private to core.c. If Uwe
> agrees it might be a good idea to move it to include/linux/pwm.h and
> assert against that, so the two can't drift apart.

Thanks for your comments. As per Gary and Uwe's feedback, I will
shorten the commit message in the v2 patch. Just to confirm, for v2
should I only update the commit message, or also move PWMCHIP_ALIGN
into include/linux/pwm.h?

Best regards,
Priya
