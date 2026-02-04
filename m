Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC531D63F0;
	Wed,  4 Feb 2026 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194411; cv=none; b=RncT6QZr3kFv5nmaMEdHyeKWVX55HQUnrziok6QVXNktverdH78bdonf3oHVkPcMbcNzm9iWoot8TSfTwE48mg/VZZ8tMs6CDM4ZrW3utxB+Iw6t9eHZxKoazPT32xhGY+GUBTsgwDMaCdCyneH21mziI2CdOmuYK8CWxmmaQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194411; c=relaxed/simple;
	bh=ieoxqjYocsy+D21C36yTN1myUqFUsHGgVBpKNl7asbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFW6bgjn58ojOR75YqWH3mN/BAKaHwJhtv1O49+Yslx4NSkV/C6C9pi8BrjFGWnWNe/8Gel+G06y/Zz2qscDVOvMxYeLEC6VUMSPYC/MyyvrCsTtjK67XhNuo+ZaQt0TPsBvS1kNJ5Prsf039jqIDNjTjDfdg21YOMtHLMJhkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gF3JseDv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gF3JseDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5ECC4CEF7;
	Wed,  4 Feb 2026 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770194411;
	bh=ieoxqjYocsy+D21C36yTN1myUqFUsHGgVBpKNl7asbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF3JseDvBu57Tja7xeL1EFQKpmvn61dQu7HKgKMBHyKt9LPKouJYAsLOv+ztErWwc
	 CWaICOxWHobZKWX/oQIcSdQVrjsSP9bMas7icS+lPyU+QQXXyRSb+uN251yReaPbcy
	 BxckdydqWniU+1pMfse2te9Suu4Eo8tke/5tdiSw=
Date: Wed, 4 Feb 2026 09:40:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Satya Durga Srinivasu Prabhala <satyap@quicinc.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Trilok Soni <tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 6/6] soc: qcom: socinfo: Convert to Rust
Message-ID: <2026020436-mascot-parachute-81da@gregkh>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-6-d6719db85637@google.com>
 <366n5psgnyptd2unf4mb2lniqfkc7n4oqbeg7oopktudwepatb@aj5bqkvt375i>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366n5psgnyptd2unf4mb2lniqfkc7n4oqbeg7oopktudwepatb@aj5bqkvt375i>

On Tue, Feb 03, 2026 at 02:27:21PM -0600, Bjorn Andersson wrote:
> I expressed my scepticism in v1 about changing this driver, for the sake
> of supporting this experiment in your downstream kernel(s). The people
> who suggested this driver to be a good candidate choose not to engage in
> either that discussion nor in the review of the solution itself.

I was told that QCOM wanted this driver to be redone in rust as that is
what they wanted to do for further socinfo drivers going forward.
Hopefully the people that said that actually talked to the kernel
developers/maintainers involved in this driver first before doing so :)

thanks,

greg k-h
