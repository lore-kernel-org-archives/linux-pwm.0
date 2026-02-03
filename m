Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED221CA13;
	Tue,  3 Feb 2026 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150445; cv=none; b=HXbGpcdpziNTm40FFplhsTyyNr3SM1SQzu5U6/smZ2Xm06mLq4PG44SHV1kqYRLgcRpOpS+gKiJsfOUIYICb90XLx2eo950qk3ANf6Ee8wOBHHee3sC94pqsL1RfqzqodfqMBQmvhUqZBfzi7yKNRHq4q+5dMlOhYnyxnXflXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150445; c=relaxed/simple;
	bh=1YWKjiDV3leaA2vWYlORbPLbYrJSUp5s40jMMZAn2KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxBL2NGmNopb+GkFq/P1Syu3O+LJsjBFuD4d+3bQiyZBCVVn/vbikKYvUplOEem8zoCTSKyi38WDTBWfGnpDrayXne1FqyWbpV503tNlN6tGEJsU9KotGVicg5ZoFDvZWa9F6lpoexGszukepcqUWk/deatXqf3ZoNW140f0xLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYIAuvLX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYIAuvLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CD4C116D0;
	Tue,  3 Feb 2026 20:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770150444;
	bh=1YWKjiDV3leaA2vWYlORbPLbYrJSUp5s40jMMZAn2KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYIAuvLX+3WuJa1XqFLRkvS2RM3ZH1MRrNy13KmXuXpqi0fM5794fasWrBY94kqFD
	 w0AvCHXxIiM3KqHcvhuT/wZnyc1r+oqy+M9boAlJj1zAqIul6m6xOo5DwpC2bhgJny
	 6+V9wrzdseTmC6Mucz4VzpqyNGJHIy8/GaiAEZdOoK0wbVnhJA2lyRYdedfBHQ9vaG
	 mIN/1yNfravxFWJe0YXSc7QpnPET/yyfMveFFaki9TKahA1RVuRk2aRkqKVbuQQGQA
	 a+jHXHf1YX7Eufrm3UNKGWHo3KELLy4jVLNHh2p1JBbMhfyIBE3ZzEvJ4nIcUnT3Kv
	 8MQedNspv4+vQ==
Date: Tue, 3 Feb 2026 14:27:21 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Matthew Maurer <mmaurer@google.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
	Satya Durga Srinivasu Prabhala <satyap@quicinc.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Trilok Soni <tsoni@quicinc.com>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 6/6] soc: qcom: socinfo: Convert to Rust
Message-ID: <366n5psgnyptd2unf4mb2lniqfkc7n4oqbeg7oopktudwepatb@aj5bqkvt375i>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-6-d6719db85637@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-qcom-socinfo-v2-6-d6719db85637@google.com>

On Tue, Feb 03, 2026 at 03:46:35PM +0000, Matthew Maurer wrote:
> Convert the socinfo driver to Rust for a number of improvements:
> * Accessing IO mapped regions through the IO subsystem, rather than
>   through regular memory accesses.
> * Binds the device as an auxiliary device rather than a platform device,
>   ensuring the mapped IO regions cannot be accessed after the smem
>   device is removed.
> * Adds bounds-checking to all accesses, hardening against a repeat of
>   CVE-2024-58007
> 

These three bullet represents things that would be good to fix (in the
C-implementation), but the commit message does not describe the problem
that a complete Rust-rewrite solves.


I expressed my scepticism in v1 about changing this driver, for the sake
of supporting this experiment in your downstream kernel(s). The people
who suggested this driver to be a good candidate choose not to engage in
either that discussion nor in the review of the solution itself.

[..]
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index fef840b5457407a85051ded0e835430dbebfe8bb..dcea2d7f37067b0b6f801b3d2b457422ad9f342c 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/auxiliary_bus.h>
>  #include <linux/hwspinlock.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -279,7 +280,6 @@ struct qcom_smem {
>  	struct hwspinlock *hwlock;
>  
>  	u32 item_count;
> -	struct platform_device *socinfo;
>  	struct smem_ptable *ptable;
>  	struct smem_partition global_partition;
>  	struct smem_partition partitions[SMEM_HOST_COUNT];
> @@ -675,6 +675,32 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +/**
> + * qcom_smem_get_aux() - resolve ptr of size of a smem item
> + * @aux:        an aux device that should be our child
> + * @host:	the remote processor, or -1
> + * @item:	smem item handle
> + * @size:	pointer to be filled out with size of the item
> + *
> + * Looks up smem item and returns pointer to it. Size of smem
> + * item is returned in @size.
> + *
> + * The caller may take the loaded state of the provided aux device as
> + * an acceptable proxy for this memory being valid.

Is this sentence trying to say "The purpose of this function is to
implicitly bind the life cycle of the returned pointer to the life of
the child auxiliary_device, which has due to devres will not outlive the
mapping of this pointer"?

IMHO this represents a very specific corner case and any other - real -
use-case of accessing SMEM would have to solve this problem properly.

> + *
> + * Return: a pointer to an SMEM item on success, ERR_PTR() on failure.
> + */
> +void *qcom_smem_get_aux(struct auxiliary_device *aux, unsigned int host,
> +		unsigned int item, size_t *size)
> +{
> +	if (IS_ERR(__smem))
> +		return __smem;
> +	if (aux->dev.parent != __smem->dev)
> +		return ERR_PTR(-EINVAL);
> +	return qcom_smem_get(host, item, size);
> +}
> +EXPORT_SYMBOL_GPL(qcom_smem_get_aux);
> +
>  /**
>   * qcom_smem_get() - resolve ptr of size of a smem item
>   * @host:	the remote processor, or -1
> @@ -684,6 +710,9 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
>   * Looks up smem item and returns pointer to it. Size of smem
>   * item is returned in @size.
>   *
> + * It is up to the caller to ensure that the qcom_smem device remains
> + * loaded by some mechanism when accessing returned memory.
> + *
>   * Return: a pointer to an SMEM item on success, ERR_PTR() on failure.
>   */
>  void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
> @@ -1127,6 +1156,7 @@ static int qcom_smem_probe(struct platform_device *pdev)
>  	struct smem_header *header;
>  	struct reserved_mem *rmem;
>  	struct qcom_smem *smem;
> +	struct auxiliary_device *socinfo;
>  	unsigned long flags;
>  	int num_regions;
>  	int hwlock_id;
> @@ -1234,19 +1264,15 @@ static int qcom_smem_probe(struct platform_device *pdev)
>  
>  	__smem = smem;
>  
> -	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
> -						      PLATFORM_DEVID_NONE, NULL,
> -						      0);
> -	if (IS_ERR(smem->socinfo))
> -		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
> +	socinfo = devm_auxiliary_device_create(&pdev->dev, "qcom-socinfo", NULL);
> +	if (IS_ERR(socinfo))
> +		dev_dbg(&pdev->dev, "failed to create socinfo device\n");

I wouldn't mind transitioning this to auxiliary_device independent of
this effort.

Regards,
Bjorn

>  
>  	return 0;
>  }
>  
>  static void qcom_smem_remove(struct platform_device *pdev)
>  {
> -	platform_device_unregister(__smem->socinfo);
> -
>  	__smem = NULL;
>  }
>  
