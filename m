Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963241A77D;
	Wed,  5 Aug 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925382; cv=none; b=rL6F+tQS2wBscT4jcr+gQUhMQodWCX+yGAH2o1zn8eKyHTTcTKkcYvADxmGLGOLhfx4aqa/Y34tUsM7qni1aJ5mq+srVbtm4hDfso7kSlvQhrxD2eal6m/YInpypmpUsXiWib2zcTdpIkZi0TUjNXkAUiYHBt9RXhb2pM759j5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925382; c=relaxed/simple;
	bh=0l2S0zN0GpxcTbkT58gaoQIcbTMg0sF8TmDeAxuQHjo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Z5tYvHpkkqlvY3qdC8H4Qn2ti1eir0C+jckMwtXEOkXcat5XIzs/2/S0jXROi1MJAEQZ7YlLKSLJA0zb1vAa/vLNU6XmwYnKIxAtP6L6+/qFxKfCs+A9ry16LGFWXPnb+jp1QQul2eezRCOtaBi94jh+QGCXL++9xdDLhc1EWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rfi1gXPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rfi1gXPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198F71F000E9;
	Wed,  5 Aug 2026 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785925379;
	bh=cyXPHivpz7/nGFvnfWHuKkFg7YoK53by0qPefdjfKes=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To;
	b=Rfi1gXPyVnIUPBIQk56R8C12KGi9k0hDVHgy6BxRLPRBMZsuGxCfkvbg+jVC06ED0
	 H0VmtdF9s45aeNN/SgvqN6F7SU76YQOtf1sRWVrFMmg5q7z4SIWrwsGUaWtSfV9K0z
	 lBC7kcno7toe01ao2kqUJC6/RKYCerBI/czGsQMYBM8ZHjYUCwOsNjCrj8s8uIdrMC
	 5poJc0fLX5CVYsntFdtKMG2cq+bI02PeV8OE0ufMWetVWZs0bCoDq9634NA0HRXJ4A
	 8pG0OOtz6mKy2g1HQos+bChPq35Wbrval7txXQPfSw/ypqm93CEcLtV6mB0QcgOvQK
	 x8MWdjxH8bQLg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 12:22:54 +0200
Message-Id: <DKGXPILQQPJH.2ISNN9UUFUBGS@kernel.org>
To: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] rust: pin-init: add `ptr_init` and
 `ptr_try_init` and recommend over `__init`
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260729-merge-init-v2-0-26adf47109e7@garyguo.net>
 <20260729-merge-init-v2-3-26adf47109e7@garyguo.net>
In-Reply-To: <20260729-merge-init-v2-3-26adf47109e7@garyguo.net>

On Wed Jul 29, 2026 at 5:38 PM CEST, Gary Guo wrote:
> The `__init` method is not designed to be a public API (existence of "__"
> is a hint for this); but currently there is no other API that allows raw
> initialization on pointers. Add `ptr_init` and `ptr_try_init` and recomme=
nd
> people to use this instead if raw pointer initialization is needed.

How about we call these two functions `raw_init` and `raw_try_init`
respectively? I feel like that conveys the meaning of what they are
doing much better.

With that: Reviewed-by: Benno Lossin <lossin@kernel.org>

Cheers,
Benno

> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/pin-init/examples/static_init.rs |  5 +++--
>  rust/pin-init/src/lib.rs              | 32 +++++++++++++++++++++++++++++=
++-
>  2 files changed, 34 insertions(+), 3 deletions(-)
