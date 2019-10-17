From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] pwm: bcm-iproc: prevent unloading the driver module while
 in use
Date: Thu, 17 Oct 2019 12:29:08 -0700
Message-ID: <b5ebfe5b-1c5a-8349-d232-d69f28024d35@gmail.com>
References: <20191017192218.9042-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191017192218.9042-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

CgpPbiAxMC8xNy8yMDE5IDEyOjIyIFBNLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToKPiBUaGUg
b3duZXIgbWVtYmVyIG9mIHN0cnVjdCBwd21fb3BzIG11c3QgYmUgc2V0IHRvIFRISVNfTU9EVUxF
IHRvCj4gaW5jcmVhc2UgdGhlIHJlZmVyZW5jZSBjb3VudCBvZiB0aGUgbW9kdWxlIHN1Y2ggdGhh
dCB0aGUgbW9kdWxlIGNhbm5vdAo+IGJlIHJlbW92ZWQgd2hpbGUgaXRzIGNvZGUgaXMgaW4gdXNl
Lgo+IAo+IEZpeGVzOiBkYWE1YWJjNDFjODAgKCJwd206IEFkZCBzdXBwb3J0IGZvciBCcm9hZGNv
bSBpUHJvYyBQV00gY29udHJvbGxlciIpCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KClJldmlld2VkLWJ5OiBGbG9yaWFu
IEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4KLS0gCkZsb3JpYW4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
