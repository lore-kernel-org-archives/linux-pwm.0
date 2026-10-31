Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793443066;
	b=bDBvA5YC7BG9oXXOg4+A0SmCoF4TCfRIEmoUb/t4vNXF+qvH15nH96on6MnCXM6N+9RS
	 7R/ONR7lTt3oITv1qDSCByFJhCEt51x/Uj4b45cUyXOclWWCYbpacQjYp5daTaGMYqUyo
	 8tzJXoJuBRo0p6+F5ZM9mgTPTrU3nDrpZn3RfE2srwFCftUzKGvY4zfLyPxUTt2j6r+DF
	 KkvF01EnuH0WokNTW8th4utRiz9Izbcbtmm1QQ0s5lBYRTGcxgP/Z3KWfEWkySspRE2Ad
	 maFF6lOxrv5EvY0JCMQA4p2K5My/Wu3ZOBBXw0tAIAhW6GPhMtUINIapX6qlfvY7y+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793443066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=51xyznyCe9WelvYeEXo4BU/h4Ecjz+qWRQ0TYPxSgHU=;
	b=k4KgnYTSuB1LKenWjjVhgNzEOpru4j+cYb3rrhNxM1JE2CykQ+Id6bXgqWjumsFOz7sG
	 HdNfqSfAj3g+DrqoRMrbSkRNUoMsoCMnksi/hSZCKl83UyM55J6BIIbpO8PLS40rN6Y7U
	 4I35AMxYVvYJgD9Er9Zo6J2+tuIgXP+Nbb2Mf11n/iO7quNC+4L06WHULvQnbW2bKKBv1
	 x8hqLx+0ooTUmWOQGcqrYhcgWqlGWeYl96Kh9c9JgWgSFRAnDeEwc61qgbkyjirzkha0H
	 K5z1DrkhzacujliZyIULFxLQgIBVuaj3zj9Ppr/uUeEiJ0t/+wLhctz2rdd+Dg9KuJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dPQjtw2S;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459B606A31A
	for <linux-pwm@vger.kernel.org>; Sat, 31 Oct 2026 10:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D459B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dPQjtw2S
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a24f47293so897350eec.0
        for <linux-pwm@vger.kernel.org>; Sat, 31 Oct 2026 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793443065; x=1794047865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=51xyznyCe9WelvYeEXo4BU/h4Ecjz+qWRQ0TYPxSgHU=;
        b=dPQjtw2SACLf3ETR8QxkgR7Te92fDh1hjirWXN2bkWeNt6pLlVwx0jkz2uxXVdSy2y
         ZfSbPGx7c7cuhDDPh0dOiWeHrgZM3AWu7uztKwIHin9UcHol3WqUuw8qalRqiUf0EfYQ
         JblG3WKndZMaKJElZJLujp/KUnXKp/NS8oJyNyIllfNP7rYT7BqqErkZmKOKNSQC21Tg
         xXI/FuWmlDZuLDMkCxI97IUgfbybSoAHJBW+Fiww9FJ2sQY6+Qkv5WP+KVqf0UISDGkg
         n4qBEg5fhJXOtqpk7wVABCK1hGu7SutDoHp2DKvKHROUlsRhM3d1G3zrAL+7AgLmoxqx
         pPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793443065; x=1794047865;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=51xyznyCe9WelvYeEXo4BU/h4Ecjz+qWRQ0TYPxSgHU=;
        b=L0ohoWNOvYis2LKQ7kQZnLRuQdW+WrvL7mMW/FSf7HFIQZS6poImFfud37JgEFz1s2
         KB3GVreY3yTyW1GK4wlTKluFlbZ54DkVWaxNrnFKsgZUDRntJf32kxUfb5foTEYpMDeM
         d9oJwN5E9U7Pdmx5B+u7+TtZFggBsKXsBwql8C27j6Vi5OJsgy8pPBYsjADDwIoeGgW5
         RfEichjFVVNk3ol0D/n9WulJwEPhy8/GwIf10zvBUmP3f5OVrH7xN8T5J9ZpwGPlC+Mn
         LzWlv/5dPJkNUU9lomm8uDnRtd7/3xicjOn+9BQLrSh2Z/8lmtG2lxlv4Lr/SaQjM6U2
         mdNw==
X-Forwarded-Encrypted: i=1; AKwUvBwH9GnTi4Jl1ksUETWzl8b9KFEDFFwHGIZ6YDY5Jxsy7HlY8iCHQTJZ5BTCY+UIYdg9q/epxmXyHAU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMt+GIt7P8mE8C1pQXdxQG77PjRrklq6odZcGGfugT7EAVnPQk
	NG0s76Fo/awoSNF9LcDLDOt+yhFze3vUGesGHaAZsgRFlW42kfl4Ps4=
X-Gm-Gg: AYBFou0fyOswIXTJBDH9UDX/lg4FGEN1fXsr/zQhIqn8M5BEe6sxg+lsxp3MzFeb3QA
	BhW1ULmPCCHJTFYY9PnzWiwtatNmXn8qfOfxEnavsndNN0pQJSmNWuit0v/MdxqPKVtREOMcC/X
	Zu8JaLmIunRkPaMSEg0WblEUxi35nxlzI5l+thPR6e7qd7RD99bOY/+9yViRIQ8qnIfgP4varIz
	xeh0nuyALXJAZQKE1rYQatf42kOOpAm2L43UsvTiaXlvtB9q2AoiPZhZcCdZxgy980EkRXNb9Xh
	By2m9fna0gnENagjXZErYzd2b2J+2Jo8ZEGHKzZlOnYNsbViEG2zroauhtMJA/O4uboWNiSYtnG
	FWmUS0Dipm8MuXX4i+ITGsLXhL164gtiWhcAcIODrx5usKJCzpQQi3u+OQkhHBl9hOk/lEW4Ja2
	NB5/hrKejPdksPkF6WOjdtfRRBEMYqfaB8MnA8PmyrmRgmKrwFbYdDiT+kXA6Xoog2zmBhnAYV7
	c7oRTKIeEKZ31s7tvOPZ/hBG4ZgTtFaGQ9KQk2xL9CpWqVWwa6Xc+b9ttrmo4buq2kcAkgQ5018
	SnTpeKVArc5QIGetBpVBpH+P3+Mrhfvm3IWLZwvMcDdJjkf47n07qserdBufyQ==
X-Received: by 2002:a05:7300:ce08:b0:343:ff9f:26f3 with SMTP id 5a478bee46e88-36a42401de6mr6495441eec.9.1793443064825;
        Sat, 31 Oct 2026 03:37:44 -0700 (PDT)
Received: from WIN-2DEDQG69EF6.localdomain ([2a13:a5c6:1ff1:280f:be24:11ff:feb0:8690])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm17019810eec.3.2026.10.31.03.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:37:44 -0700 (PDT)
From: chenhan <chenhan0017.work@gmail.com>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: fustini@kernel.org,
	guoren@kernel.org,
	ojeda@kernel.org,
	ukleinek@kernel.org,
	wefu@redhat.com,
	a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	gary@garyguo.net,
	linux-riscv@lists.infradead.org,
	lossin@kernel.org,
	m.wilczynski@samsung.com,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH v3 0/2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
Date: Sat, 31 Oct 2026 18:37:34 +0800
Message-Id: <20261031103734.24734-1-chenhan0017.work@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030020209.3833766-1-tomo@flapping.org>
References: <20261030020209.3833766-1-tomo@flapping.org>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tomonori,

Thanks for CC'ing me.

> Both series use the same module header, so whichever
> is applied later needs only a small rebase.

Agreed. My div64_s64() and div_s64_rem() can share math.rs with your
div64_u64() and div64_u64_round_up(). If your series lands first, I will
rebase patch 3 onto that module, preserving your unsigned helpers and
the common module header.

I have now posted v5 [1], which only changes the SAFETY comments relative
to v4. The first two patches still fix Delta independently of the math
module, so the behavior fix can be taken separately from the extraction.

[1] https://lore.kernel.org/rust-for-linux/20261031103206.24051-1-chenhan0017.work@gmail.com/

Best regards,
chenhan
