Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044229;
	b=I+cgQvjaN04IGFS1BBf8zWHMLVw09zqIzxdPw8UE9jiHz2Oaq1wO+zQcqVY6xOgP38AF
	 oWH030rPcXdfrPm+ZU77HVKyA134+s55Qy/la+p+4PFWHcW42roemwcYW2UG7Q66IbZfI
	 HwrEyJKmENmeHNlcnWKRDX48uj8whgktxKXQFkbrVZlwf2Bfxp+NKVszYWH8kYb/yZXwP
	 zuWfoJFzqIkwhrtTzipRv44SJTK98NhWjhLElqed3q4Sw5TdJV4NLFW5ti7jYD5LKz1A9
	 qExLLpR8Wzr/MdddWMVsgNWqtkjMfYw/VG4vtGuU1GltX8CftBnLPaRL+WSvRm4VB6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=BNtN55GYuVsPPt5uRpwb+HzLieno6rlFAiQ19PmBpDM=;
	b=T7EVfTsuNW6s6vZRTb0/+KPV4p+/66tHUwJtF+6Z7lJ+gCf7Fp5W8KDfnG4T3eozyoh5
	 ljQEw5Xhsep9Gy9fNnR6jGyN8bMfT2eoOGAo4stVriDUbc+bAZTcD1lcytIyOdVqx4pT8
	 +VIVS2BRAhRe8OBYPoW/mwSZ8Rwb6455cKlrJgHdfe3pzhTstpHu2+M2KmLKjlyyTKpIZ
	 9K0BSEpjJ2I6r0FjJsR0fWL89yngYNlfCqwdgsHHD8ISSHgOCcYLB7apXJFPT3/+xrNQq
	 CWrV4ucmM51ylWrPLVe/zm+usKgB06NqPNTbXegj1eISrw8K0tTQWFiwCGzAI/3I9/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TE7GF2Io;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738D606A32A
	for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 23:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9738D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TE7GF2Io
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-49034831bb3so1053329f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 15:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795044227; x=1795649027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BNtN55GYuVsPPt5uRpwb+HzLieno6rlFAiQ19PmBpDM=;
        b=TE7GF2Io74oN7GLFOgnUS+9NnHQI+mRCX2/LGNqharVkbEV2rcrIoCEBu0a8PAd1jT
         0YWftalTkS6Bhgk3JPapQbWIzID75yquOWxybHPrTlr5Yr8n496NznOhFTUXpa0bivPj
         9wO/rHY+ZJCLxLKc6a0FQp3SB/SEcEmqOuX+AgpJOKnsmyzcDNlamQs5V/g1M/XqT0PX
         SfMVSnwOqprt2jH9gZJYyz5Turj05ne96HpUsoGt2KjkuPkoGZXzAdFO93K3fE342zbp
         8L5i87sLBVzZ9xpqBJjSVt8PLmMDqBk1PqNJs2U/8W+0XkuaLlclpO1q8Vj6jtUnrTPN
         yRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795044227; x=1795649027;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNtN55GYuVsPPt5uRpwb+HzLieno6rlFAiQ19PmBpDM=;
        b=rZ5GtlxLd1tS3DuG9pYTSlEfra/Z94epbX0PW7P6ZnygW20MepVMBqJzu6HhTm0UJn
         5xBLr8Vii55gSJfRJjfqquXcP/1zEN9Um2Njjt6Ky4A3PvF73qMH56pZ+vzAF9ynOsJ9
         +roThDqJ/3sKhh1ZYbPB5nu8WYXy1BbxhmdSei55f02y7HiJ1iOFNct3YCz0cBX4vt5R
         ETu/7NW/vf2fwuRWddHpRzS8mqiXaaLby4Ji9jo4IE0kJCrFiW2dz38XnqMechmCA/le
         BmbtjwLQLp9AEfN5UemPbGRskO1zSobSOBcKbM7eiINd7cWKzHETxMJ49ZK83wxCVZvK
         6Akg==
X-Forwarded-Encrypted: i=1; AL+hErFae+Dv8aDHMLxFZQbefSFc8unlDkB2umflo8rkP1+YnyeuW5cyVlx6oAB+FKGCIdBliTm12tgQ4S4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+owh2McO0MIL/MYQKb3IaenBmYPsA3vEVKfIRIxTMujQcRwzf+
	LV233u63QsjXRCRN/FD7EVatPg58DN950+TP8Vv06ybh63dd+/mIOiP67p5l3mch2JYOrW+G57Y
	vAlnAY2pzhZxTD/Zr8A==
X-Received: from wrqk2.prod.google.com ([2002:a5d:4282:0:b0:4a5:9a8b:7c4e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4029:b0:4a6:d298:832e with SMTP id ffacd0b85a97d-4a6d298857bmr7425526f8f.45.1795044226494;
 Wed, 18 Nov 2026 15:23:46 -0800 (PST)
Date: Wed, 18 Nov 2026 23:23:45 +0000
In-Reply-To: <20261118224826.2491684-3-tomo@flapping.org>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118224826.2491684-1-tomo@flapping.org> <20261118224826.2491684-3-tomo@flapping.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118232345.1511641-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 2/2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
From: Alice Ryhl <aliceryhl@google.com>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: Alice Ryhl <aliceryhl@google.com>, fustini@kernel.org, guoren@kernel.org, 
	ojeda@kernel.org, ukleinek@kernel.org, wefu@redhat.com, a.hindborg@kernel.org, 
	acourbot@nvidia.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	chenhan0017.work@gmail.com, dakr@kernel.org, daniel.almeida@collabora.com, 
	gary@garyguo.net, linux-riscv@lists.infradead.org, lossin@kernel.org, 
	m.wilczynski@samsung.com, tamird@kernel.org, tmgross@umich.edu, 
	work@onurozkan.dev, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	"=?utf-8?q?Uwe_Kleine-K=C3=B6nig?=" <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 07:48:26AM +0900, FUJITA Tomonori wrote:
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> Fix the following build error on 32-bit ARM with COMPILE_TEST:
>
>   ERROR: modpost: drivers/pwm/pwm_th1520.ko: symbol '__aeabi_uldivmod' un=
defined!
>
> The driver divides u64 values when it converts between nanoseconds and
> clock cycles. On 32-bit ARM, these divisions are compiled to calls to
> __aeabi_uldivmod, which the kernel does not provide.
>
> Use div64_u64() and div64_u64_round_up() for these divisions, in the
> same way as C drivers use div64_u64() and DIV64_U64_ROUND_UP(). The
> results do not change.
>
> Fixes: 3c180003dffb ("pwm: th1520: Fix missing Kconfig dependencies")
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/=
topic/64bit.20division.20in.20.60pwm_th1520.2Ers.60/near/626825599
> Suggested-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
