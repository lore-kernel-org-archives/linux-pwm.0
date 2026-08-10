Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB83AF640
	for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2026 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354919; cv=none; b=N8BG5oHfoVklbD9xAD06YXpmo2Qk2y23Gr5Z093lDTwDwPMnACcvlVFr+FCQunDNKDEFU4UEWYDh6HVdwmWrYPzZwpfexw5841K035nsHQXzQSdZcGgMslP/eBwmltcMFccTOBU70G2IKwI8AyYTUi8tdzv44vZsKvQxh2LkVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354919; c=relaxed/simple;
	bh=lAlJ21024iVEAiB1omuqDYIS76cnSpFr0AtgmGJNB4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=T34K457fhWcphadSZ/UzBN8bqYHxZhqdzy5NjOAVkie14FOz1UxaZxhTx42PdPwnlL4Z7lT95y/n8XviY/Zi3Vzy6IWTX+AXlDUvBoKUQ2HE0pK0MY76m303PRO1ey/xx8c/ebwxWszleXK+7CBwbIR/n0rC1YHx92i8mfrt9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ble4axPc; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ble4axPc"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260810094154euoutp027f1cc6a6a3ee3d16f099079a9665c0d4~KaFSc_5wX1630116301euoutp02H
	for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2026 09:41:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260810094154euoutp027f1cc6a6a3ee3d16f099079a9665c0d4~KaFSc_5wX1630116301euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786354914;
	bh=AmOptGmSSwb48Q3nQS4iFyaNRaAar+3mAWyPKqr/PZc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ble4axPczDpJRsTJenkxPmIfVecz+JLi0iHpAR4YcF2TnitaLf9xU89sxJ2AwaBgZ
	 /JMG0I5RUxNOgAqqlbGedKylHLO58WWFx6CUtasFjhL8YGvVKF90lp9KTw8buQj1wm
	 QuYm6V7Vke4seybUzDddIxlxx2jCaqqmquQ/kQvs=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260810094154eucas1p14114a0cb677a4b4da96242f50cae88c0~KaFR42qow0110201102eucas1p1u;
	Mon, 10 Aug 2026 09:41:54 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260810094153eusmtip22c92126836a048d2e2c83409f520ae1c~KaFQzzhe_0770707707eusmtip2n;
	Mon, 10 Aug 2026 09:41:53 +0000 (GMT)
Message-ID: <7418f71a-cf53-4641-bdf3-e967e776b0a8@samsung.com>
Date: Mon, 10 Aug 2026 11:41:52 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: th1520: use vertical import style
To: Guru Das Srinagesh <linux@gurudas.dev>, Link Mauve
	<linkmauve@linkmauve.fr>, Drew Fustini <fustini@kernel.org>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel
	Almeida <daniel.almeida@collabora.com>, Tamir Duberstein
	<tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260721-pwm-rust-vert-imp-v2-1-9f91547f5e07@gurudas.dev>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260810094154eucas1p14114a0cb677a4b4da96242f50cae88c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260721074943eucas1p20eaf6768a8a3db90d29a9d45746554ab
X-EPHeader: CA
X-CMS-RootMailID: 20260721074943eucas1p20eaf6768a8a3db90d29a9d45746554ab
References: <CGME20260721074943eucas1p20eaf6768a8a3db90d29a9d45746554ab@eucas1p2.samsung.com>
	<20260721-pwm-rust-vert-imp-v2-1-9f91547f5e07@gurudas.dev>

Hi,

On 7/21/26 09:49, Guru Das Srinagesh wrote:
> Convert `use` imports to vertical layout for better readability and
> maintainability.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
> Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
> vertical import style") and found a few more locations that could
> benefit from this cleanup. No functional changes.
> 
> Separating out patches per-subsystem as per the review feedback in [0].
> 
> Tested via:
> 
>     $ make LLVM=1 rustfmtcheck || echo "fail"
>     $
> 
> [0]: https://lore.kernel.org/lkml/20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev/
> ---

Looks good to me,

Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>

