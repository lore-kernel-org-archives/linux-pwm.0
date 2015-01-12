From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v8 1/2] pwm: Imagination Technologies PWM DAC driver
Date: Mon, 12 Jan 2015 21:04:22 +0000
Message-ID: <20150112210422.39f715a2@lxorguk.ukuu.org.uk>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
	<1420826088-13113-2-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:41792 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbbALVEn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Jan 2015 16:04:43 -0500
In-Reply-To: <1420826088-13113-2-git-send-email-ezequiel.garcia@imgtec.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Andrew Bresticker <abrestic@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, James Hartley <james.hartley@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vladimir_zapolskiy@mentor.com, Naidu Tellapati <naidu.tellapati@gmail.com>, Naidu Tellapati <Naidu.Tellapati@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

What if you've not been given a resource ?

Otherwise looks fine to me
