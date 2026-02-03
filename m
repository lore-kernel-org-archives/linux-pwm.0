Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90453939BF;
	Tue,  3 Feb 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137303; cv=none; b=oPwt5Wb7xrX/liY1fdsidatwFe+Q339EqiFt6uIbPjF3eCYknKbggN6XXQsw9OVtiUrRkWN0zp64/CMOPZ5Ro4XSNE/fsiDl1K0smz5QGaokBkegyecFteCQyzy+gKmnJUeoLsoJEbXGyBE+CQvtrY80e9lc9b5VanQwx74FP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137303; c=relaxed/simple;
	bh=FvC5tWe+mnSdPgM1ZC8nBW089ocEvsBpJxWtb6qOlR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKPELBAmzeXd6sBJDJk8QA+SqtVMKy7M61mL1UqML6y7bwmQ7csywaxfkksjQjjH8b4w6qtsatDIlIyQIPbmPHQhPOpDHlR0EN4Xw1B+k7XuA+5FHZe/CIROdkRe7/EbtivtDrQwNOtn+MbVrZTASMpsnkcPMFSxlpJWqXaXFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F8/jdfWx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F8/jdfWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DA1C116D0;
	Tue,  3 Feb 2026 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770137302;
	bh=FvC5tWe+mnSdPgM1ZC8nBW089ocEvsBpJxWtb6qOlR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8/jdfWxbjQOFtTqTo6oUQxj/S90hqcAspINUKm10FNLlUpaEVlnUe4MCKI0DBttD
	 GgyF1acx1V69PYwiR46wZrsMrhkvDwD2IYFAnLK6Dlrpm6THkBac/6rlpIR4iJC7z9
	 oC1PFINT1vZG6ZQ7g0hCXYJtozNATvazEMDZCz7U=
Date: Tue, 3 Feb 2026 17:48:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Satya Durga Srinivasu Prabhala <satyap@quicinc.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
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
Message-ID: <2026020347-sneak-embark-1b36@gregkh>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-6-d6719db85637@google.com>
 <2026020315-conch-trickle-2d84@gregkh>
 <DG5H119NY68Q.TWLCK3W36CM5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG5H119NY68Q.TWLCK3W36CM5@kernel.org>

On Tue, Feb 03, 2026 at 05:35:24PM +0100, Danilo Krummrich wrote:
> On Tue Feb 3, 2026 at 5:28 PM CET, Greg Kroah-Hartman wrote:
> > On Tue, Feb 03, 2026 at 03:46:35PM +0000, Matthew Maurer wrote:
> >> +impl Smem {
> >> +    pub(crate) fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Option<&'a Mmio> {
> >> +        if *dev != *self.dev {
> >
> > How can this ever happen?
> 
> You are right, since this resource is local to the driver, it should not be
> possible to have another devce from somewhere else (especially not a
> &Device<Bound>).
> 
> However, from a Rust perspective I think not having this check would be unsound,
> as the method by itself would not be able guarantee correct behavor anymore.
> 

I don't really understand this last sentence, sorry.  If this is "not
possible" why would that at the same time be "unsound"?

thanks,

greg k-h
