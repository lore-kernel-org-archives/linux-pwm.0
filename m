Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C10517BB9;
	Tue, 29 Sep 2026 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684216; cv=none; b=DDpW8ELZJaeKZU0/vRPZoG1xBO6MAZ2W4PCvJd6QBdCFzmGkPOL1cMRR+Z6ou7ethCSSSZkSl3cRLnYDdbzXnMIR7M8vcps4JAYl0hnvrxAsp5O/B6HpjuLaKlZly6jvN8xd92xv2j27AnK58ViobxaWbvawRl03tIm1JIe+oMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684216; c=relaxed/simple;
	bh=8/h/dzXQG7ieL4aIS5yiXkYs33hWPfhEHw+gpilJi6I=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cWpo9DE8S8OlfNBuenRIsdmaczWOLqblKXGQ4huP3RAPG15dqYN1rWc0Wzlpv9+i9vdA0pQ51ZPD/04zzeb8rv2w8W1lFU63VQZZpYqBU5lMDKIYQTJ1dDcrESuF3R6rfDf4ygxjajt5G7+o5KFnFqYaCgNL1JwOh4um3vQ1xho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=PaIBRIap; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u6itGouU; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="PaIBRIap";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u6itGouU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6CDE41D00146;
	Tue, 29 Sep 2026 08:16:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 08:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790684213;
	 x=1790770613; bh=za2V7Z1tBaPJIsF6VbDgL/Gr5qezbehFs/mU6PCMXDY=; b=
	PaIBRIapCVAGkdluDQcWFxEojJvnJdqg9Ca+QokOkbHXr52PsbHitRM+QRKivAQ0
	/zhmW/xGI+yaYmqGggmo12VldXyoXEbi+doGj+7rd08Ay7gf5XM6J/60X6BEvSu+
	pNtrgplabhaqK+V5TK0CVjA98tnJRWxcXZpL6Oo7+9dZXYMNnOpkr0PlRT96DZ2Y
	c21KUm7QbzTIrmGiNBztBCub14McYmATgnuFtMPJm1LlnLGGKVXc/EY+iXoPayYY
	KrKlbF5jsTQ0MgpqaO71M2b+y7XqKE0PaqB2eGR5R3YKnyDXNUYd/bEJNbCTLokr
	nSc2D2XVv6xV3SvkUQpCaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790684213; x=
	1790770613; bh=za2V7Z1tBaPJIsF6VbDgL/Gr5qezbehFs/mU6PCMXDY=; b=u
	6itGouU1wWGOiE9K8Cq8xg4cz/nGiYoRf58dBJLi8IGrrsnpqqokbgXRVm11bj02
	JXXeqG7EWAA3MS+670Kf/BEYmhyK8WmqGybHmfTc1URv29KKVCfRRS5weYA6nxCZ
	dW0qwZEOjVx9v2wmDpe4mh0/JiTN5XzNdnN8KKkbjVQsMrQKjqdzkgJujPnhWu4a
	glgvBfzEVNvPcJizqHZ7+fp60h0EYY6hXjR7cpfP3OnAIODqIn3XGkOp5kgOIeLW
	m2SYw/vm6qDYd41abZf4MGktxo3i5kRtDbf7WlLd39D/Pu3o/x/PZV6pgJElrmGr
	JP2YXs/Ykn8Nnc9IhGfqQ==
X-ME-Sender: <xms:NKy7aivoPt-yzU9whJItS1CI_1wyQ5hp7CJe2u9fKp8m74W-tH6rNQ>
    <xme:NKy7apGDzPlMlXsNf8pU_PVzpkLWZdvzRudKAUEqjhS-c4df_FrYCzjTakmtE6AKC
    k8r6ZmnJ3_EnJ59tPdHiE0wBDwC7yXu4gn-6I4nu545opimiTN7cehr1A>
X-ME-Received: <xmr:NKy7ah0wtogCGUDWulbhAUuv9UnxKexysrLNDXeJd5E0kRG3a7k6fsLeEy6ymNjcjSYhBkkPrnW47hndoJuurzgn>
X-ME-Proxy-Cause: dmFkZTF3XDN4KUZZZUGh4M9PTDiqNBb6FcuQlMtMiNWj03/YHI2E605axOeGtO8rwh5R5U
    oc5us/7kkhAzrZKrZZ8cRKIL1vUnOYdO4qiciiv2I+7Sykz/YDZPm0JMSuOwEHYzbv+ykZ
    dskjQ4YYcfZPjbiUd3aRBIVeuTGp+yYQm2LXUn5SR6bndcKjmKYDyiw3OmOACZwcIbUY4w
    3aqhYQpyv5TTx91hjUvlk8VTogv4F3XRDRTm55mGTI8KANBTGlt6SMqBRHNjBs7osy+5s4
    tXvURwU71vt9lbPfGJ5ofHoqO0hRVlwUDKXOpgmbYBR3amM6bciBTW0uC6+D6IAFqURbe8
    5fBq00rJ2ITAl3TUwSblOp3P10/Kk0rXnMZAuGvxKeDpAWv+Ik1F+N6OdT189K2SNsGlrI
    RA+Yf49/1ZVtHc/bNe5+yr8NtBkKcrLTkjN5RKBTehwbWeiZBSg3F6przRU49Hy/m2oaLy
    GHRZ9qAHtLGf4gF2S0ak/vTGyg14QoGD/YvdM8IMpG1UURozLm7DnJJnlC/5uMbekgUK0H
    4QXMJufr0ngVx4170K8tzsyWnL8W7nAgC+9TJj2Q7UcbFyxjD+PwEPeMPCUtfFjlY9y07K
    JDwsUVujKtesuXe7FuVaV45zfgbXYkoY2EJ+Y2k8UCR4napQX/BobCzb6f3w
X-ME-Proxy: <xmx:NKy7ajoxmiu1K3uBw61eK0u2x1tHRffIYKGUuPMXjUg2PJW8IcwuEw>
    <xmx:NKy7ah6uU5SxcBQ8Ny05L3a4jNpPE50YByMG3k2pC7rpqTpweTV1vg>
    <xmx:NKy7ajwKCeC0g4ccpGHm4OgT0TNtk8osfPafSTgMd3TFRWztw_w74g>
    <xmx:NKy7amBUh1Ji-tVmmlxkOEQyEnpRbabMiNJgkFPcPkeOgsHtmjNnlg>
    <xmx:Nay7ai_psFI0GgBbcLrVnJuH8K3_oavvPctHcEOelv_qWsHH3CJB-UgA>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 08:16:47 -0400 (EDT)
Date: Tue, 29 Sep 2026 21:16:45 +0900 (JST)
Message-Id: <20260929.211645.1865853879579118631.tomo@flapping.org>
To: miguel.ojeda.sandonis@gmail.com
Cc: tomo@flapping.org, ojeda@kernel.org, fustini@kernel.org,
 guoren@kernel.org, wefu@redhat.com, a.hindborg@kernel.org,
 acourbot@nvidia.com, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com,
 gary@garyguo.net, lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu,
 work@onurozkan.dev, rust-for-linux@vger.kernel.org,
 linux-riscv@lists.infradead.org, ukleinek@kernel.org,
 m.wilczynski@samsung.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v1] pwm: th1520: Fix 32-bit build with COMPILE_TEST
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <CANiq72mRRajbvJzwZZzaMiG8UQT1yeHn3Cm1+MSg0VqLT22dVg@mail.gmail.com>
References: <20260929095612.1072417-1-tomo@flapping.org>
	<CANiq72mRRajbvJzwZZzaMiG8UQT1yeHn3Cm1+MSg0VqLT22dVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 13:54:05 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Tue, Sep 29, 2026 at 11:56 AM FUJITA Tomonori <tomo@flapping.org> wrote:
>>
>> he TH1520 is a 64-bit RISC-V SoC, so the driver is only used on
> 
> Cut word at the beginning.

Oops, thanks.

>> Fixes: 3c180003dffb ("pwm: th1520: Fix missing Kconfig dependencies")
> 
> Should this have Cc: stable@vger.kernel.org?

Yes, I'll add Cc: stable. The build error has been there since v6.19.

I also forgot to Cc the PWM maintainer and list, and missed the
Reported-by and Closes tags. I'll send v2 tomorrow with these fixes
and the Reviewed-by tags from Andreas and Gary.

