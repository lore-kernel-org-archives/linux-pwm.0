From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/4] ARM: S3C24XX: rx1950: make use of atomic PWM API
Date: Mon, 29 Oct 2018 11:46:15 +0100
Message-ID: <CAJKOXPfuUFzFFwJoPutQz+zYqtom8evscpq2=PafX1EbBAnC+Q@mail.gmail.com>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: u.kleine-koenig@pengutronix.de
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

T24gRnJpLCAyNiBPY3QgMjAxOCBhdCAyMDo1NCwgVXdlIEtsZWluZS1Lw7ZuaWcKPHUua2xlaW5l
LWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6Cj4KPiBUaGUgbGVnYWN5IFBXTSBBUEkgc2hv
dWxkIGJlIHJlbW92ZWQgaW4gdGhlIGxvbmcgcnVuLCBzbyBjb252ZXJ0IGEgdXNlcgo+IHRvIHRo
ZSBhdG9taWMgUFdNIEFQSS4KPgo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1
LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Cj4gLS0tCj4gIGFyY2gvYXJtL21hY2gtczNj
MjR4eC9tYWNoLXJ4MTk1MC5jIHwgMTggKysrKysrKysrLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpSZXZpZXdlZC1ieTogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPgpJIHNlZSB0aGlzIGRlcGVuZHMgb24gZmly
c3QgcGF0Y2ggc28gSSBhc3N1bWUgdGhpcyB3aWxsIGdvIHRocm91Z2ggcHdtIHRyZWUuCgpCZXN0
IHJlZ2FyZHMsCktyenlzenRvZgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
