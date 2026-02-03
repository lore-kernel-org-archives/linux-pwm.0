Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF694267714;
	Tue,  3 Feb 2026 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134221; cv=none; b=EcbEfYQQsbMTmb/T72OkV2sAikzdSom650CJi7HIAcW4Ymw3NYyS2AbTmfBqS+6jSs/U47zNJCnjgRkCsPNEtckqb/W/Kxt2/AQmtd+Fo7LCai7XKMjbzVcAX181ahNA0U0XHTMFYcZiwuUmblqk2rjuZDi9+ajo1rECimfmF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134221; c=relaxed/simple;
	bh=26nwcMryJ76wXMOtOoFHlXYsUq+qJpBWZUUKVoFPTOw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MMmAJ+sfGloJAg7Ju0SLjorIydjVqMN0HQ6vNfSUQqfvD6OQbvzhcUn09NnniMZa+wX9mRKkhjIHENH/J2iBRMiQFxgIgD+0h+2X2byqqkVoPUlgOlDU5beP50AphtH1/BlUTFsV9QHxiPaJmMEpgGwhqz0ga4FqqZjOrw0ElzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSyyG+Rw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSyyG+Rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B14C16AAE;
	Tue,  3 Feb 2026 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770134221;
	bh=26nwcMryJ76wXMOtOoFHlXYsUq+qJpBWZUUKVoFPTOw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=DSyyG+RwctKLRWyjPLYbr0C5p1akxroX0ic0fyGhuYpYE1SzjmjWtfMTboxBvL/mC
	 mHDWNnXZd32pSXdBj94iiEuI/jPIleXhciHZKIu2wVAy17SSuHvtI/SP6g2jEjppc/
	 eMvgUuoJjDmLgnkt7zK9vvRH8oULq58M0gRgrhmxjqPaWYRv50LKEP/0DOdDUHNcyv
	 lpiyAIs9kMlTIgJSVVi6bJXGzgG976hL0iknU5auRiLrqhwNKsxJVABlruhEV4ubMJ
	 mFnVYzdWEi23/+OANM/WWOnvgX6h65i1v2Sjk0q1Ms4V7uW+kb73MkC+99MU2kniTx
	 7JDOWf6A/OPrA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 16:56:53 +0100
Message-Id: <DG5G7JH81HEE.1ADZRELXEBNJD@kernel.org>
Subject: Re: [PATCH v2 3/6] rust: device: Support testing devices for
 equality
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Satya Durga Srinivasu Prabhala"
 <satyap@quicinc.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Trilok Soni" <tsoni@quicinc.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>
In-Reply-To: <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>

On Tue Feb 3, 2026 at 4:46 PM CET, Matthew Maurer wrote:
> This allows device drivers to check if, for example, an auxiliary
> devices is one of its children by comparing the parent field, or
> checking if a device parameter is its own device.
>
> Also convert existing `.as_raw() !=3D .as_raw()` to  use this new
> implementation.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

In case this should eventually go through another tree:

Acked-by: Danilo Krummrich <dakr@kernel.org>

But please let me know if you want me to pick it up.
